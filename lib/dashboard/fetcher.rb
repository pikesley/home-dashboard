module Dashboard
  class Fetcher
    REDIS = Redis.new

    def self.redis
      REDIS
    end

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

    def self.get url, ttl = 3600
      begin
        Marshal.load(self.redis.get url)
      rescue TypeError
        h = HTTParty.get url, headers: headers, query: query
        self.redis.set url, Marshal.dump(h.body)
        self.redis.expire url, ttl
        Marshal.load(self.redis.get url)
      end
    end

    def self.extract_repo url
      url.match(/https:\/\/api.github.com\/repos\/([^\/]*\/[^\/]*)\/contents.*/)[1]
    end

    def self.fetch_CSV url
      csv = get url
      CSV.parse csv
    end

    def self.fetch_metadata url
      JSON.parse(get(url))
    end

    def self.assemble_data url
      m = fetch_metadata url

      m['data'] = fetch_CSV m['download_url']
      m['repo'] = extract_repo m['url']

      m
    end

    def self.list_CSVs repo
      url = ['https://api.github.com/repos', repo, 'contents'].join '/'
      JSON.parse(get(url)).select { |i| i['name'].match /\.csv$/ }.map { |c| c['url'] }
    end

    def self.fetch_CSVs repo
      c = []
      self.list_CSVs(repo).each do |url|
        c.push assemble_data url
      end

      c
    end
  end
end
