module Dashboard
  class Cleaner
    def self.lookups
      YAML.load_file 'config/lookups.yml'
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

      j['title'] = titleise(d)
      j['name'] = d['name']
      j['url'] = d['_links']['html']
      j['data'] = d['data']

      j
    end

    def self.titleise data
      trimmed = data['name'].sub(/\.csv$/, '')
      if lookups.has_key? data['repo']
        if lookups[data['repo']].has_key? trimmed
          if lookups[data['repo']][trimmed].has_key? 'title'
            return lookups[data['repo']][trimmed]['title']
          end
        end
      end

      trimmed.split('-').map { |w| w[0].upcase + w[1..-1] }.join ' '
    end
  end
end
