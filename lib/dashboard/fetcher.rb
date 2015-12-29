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

    def self.get url
      HTTParty.get url, headers: headers, query: query
    end

    def self.fetch_CSV url
      csv = get url
      CSV.parse csv
    end

    def self.fetch_metadata url
      JSON.parse get(url).body
    end

    def self.assemble_data url
      m = fetch_metadata url
      m['data'] = fetch_CSV m['download_url']

      m
    end

    def self.list_CSVs repo
      url = ['https://api.github.com/repos', repo, 'contents'].join '/'
      get(url).select { |i| i['name'].match /\.csv$/ }.map { |c| c['url'] }
    end

    def self.fetch_CSVs repo
      self.list_CSVs(repo).each do |csv|
      #  csv['content'] = self.get_CSV(csv['download_url'])
      end
    end
  end
end
