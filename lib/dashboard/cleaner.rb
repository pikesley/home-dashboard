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
      j['id'] = trim d['name']
      j['date-field'] = lookups.dig(d['repo'], 'datasets', trim(d['name']), 'date-field') || 'Date'
      j['type'] = lookups.dig(d['repo'], 'datasets', trim(d['name']), 'type') || 'latest'
      j['url'] = d['_links']['html']
      sf = lookups.dig(d['repo'], 'datasets', trim(d['name']), 'special-fields')
      j['special_fields'] = sf if sf
      j['data'] = jsonise d['data']

      j
    end

    def self.trim string
      string.sub /\.csv$/, ''
    end

    def self.titleise data
      trimmed = trim data['name']
      lookups.dig(data['repo'], trimmed, 'title') || trimmed.split('-').map { |w| w[0].upcase + w[1..-1] }.join(' ').singularize
    end
  end
end
