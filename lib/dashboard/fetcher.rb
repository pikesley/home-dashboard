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

    def self.list_CSVs repo
      url = ['https://api.github.com/repos', repo, 'contents'].join '/'
      headers = {
        'Accept' => 'application/vnd.github.v3+json',
        'User-agent' => "Dashboard v#{VERSION}"
      }
      query = {
        'client_id' => ENV['GITHUB_CLIENT_ID'],
        'client_secret' => ENV['GITHUB_CLIENT_SECRET']
      }

      h = HTTParty.get url, headers: headers, query: query
      h.select { |i| i['name'].match /\.csv$/ }
    end
  end
end
