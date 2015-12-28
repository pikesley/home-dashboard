module Dashboard
  class Fetcher
    def self.headers
      {
        'Accept' => 'application/vnd.github.v3+json',
        'User-agent' => "Dashboard v#{VERSION}"
      }
    end

    def self.query
      {
        'client_id' => ENV['GITHUB_CLIENT_ID'],
        'client_secret' => ENV['GITHUB_CLIENT_SECRET']
      }
    end

    def self.get_CSV url
      csv = HTTParty.get url, headers: self.headers, query: self.query
      CSV.parse csv
    end

    def self.newest csv
      csv.shift
      csv.sort.last
    end

    def self.list_CSVs repo
      url = ['https://api.github.com/repos', repo, 'contents'].join '/'

      h = HTTParty.get url, headers: self.headers, query: self.query
      h.select { |i| i['name'].match /\.csv$/ }
    end

    def self.fetch_CSVs repo
      self.list_CSVs(repo).each do |csv|
        csv['content'] = self.get_CSV(csv['download_url'])
        csv['newest'] = self.newest(csv['content'].clone)
      end
    end
  end
end
