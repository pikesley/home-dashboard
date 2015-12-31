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
      redis = Redis.new
      if redis.get url
        return redis.get url
      end

      h = HTTParty.get url, headers: headers, query: query
      redis.set url, h.body
      redis.expire url, 3600
      h
    end

    def self.extract_repo url
      url.match(/https:\/\/api.github.com\/repos\/[^\/]*\/([^\/]*)\/contents.*/)[1]
    end

    def self.fetch_CSV url
      csv = get url
      CSV.parse csv
    end

    def self.fetch_metadata url
      JSON.parse get(url)
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
