module Dashboard
  class Cleaner
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
      require "pry" ; binding.pry

      j['title'] = titleise(d['name'])
      j['singular'] = j['title'].singularize
      j['name'] = d['name']
      j['url'] = d['_links']['html']
      j['data'] = d['data']

      j
    end

    def self.titleise string
      string.sub(/\.csv$/, '').split('-').map { |w| w[0].upcase + w[1..-1] }.join ' '
    end
  end
end
