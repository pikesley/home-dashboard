module Dashboard
  describe Fetcher do
    before :each do
      Redis.new.flushall
    end

    after :all do
      Redis.new.flushall
    end

    it 'stores a value in Redis', :vcr do
      url = 'https://raw.githubusercontent.com/pikesley/snake-data/master/length.csv'
      described_class.get(url)
      expect(Marshal.load(Redis.new.get(url))).to eq(
"""\
Date,Length in m
2014-09-30,0.45
2014-10-09,0.50
2014-10-18,0.50
2014-12-12,0.55
2015-01-11,0.60
2015-01-28,0.65
2015-08-27,0.95
"""
      )
    end

    it 'expires a value after the timeout', :vcr do
      url = 'https://api.github.com/repos/pikesley/catface/contents/flea-treatment.csv?ref=master'
      described_class.get(url, 1)
      expect(Redis.new.get url).to_not be nil
      expect(Redis.new.ttl url).to eq 1
      sleep 1
      expect(Redis.new.get url).to be nil
    end
  end
end
