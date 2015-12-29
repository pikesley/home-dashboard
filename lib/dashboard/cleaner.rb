module Dashboard
  class Cleaner
    def self.titles
      YAML.load_file 'config/titles.yml'
    end

    def self.jsonise csv
      j = []

      keys = csv.shift

      csv.each do |line|
        h = {}
        keys.each_with_index do |key, i|
          h[key] = line[i]
        end
        j.push h
      end

      j
    end

    def self.sanitized_data url
      j = {}
      d = Fetcher.assemble_data url

      j['title'] = titleise(d['name'])
      j['name'] = d['name']
      j['url'] = d['_links']['html']
      j['data'] = d['data']

      j
    end

    def self.titleise string
      trimmed = string.sub(/\.csv$/, '')
      if titles.has_key? trimmed
        return titles[trimmed]
      end

      trimmed.split('-').map { |w| w[0].upcase + w[1..-1] }.join ' '
    end
  end
end
