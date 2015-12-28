module Dashboard
  class Fetcher
    def self.get_CSV repo, file
      url = ['https://raw.githubusercontent.com', repo, 'master', file].join '/'
      csv = HTTParty.get url
      CSV.parse csv
    end

    def self.newest repo, file
      c = self.get_CSV repo, file
      c.shift
      c.sort.last
    end
  end
end
