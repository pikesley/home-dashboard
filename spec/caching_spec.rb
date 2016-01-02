module Dashboard
  describe Fetcher do
    before :each do
      Redis.new.flushall
    end

    it 'stores a value in Redis', :vcr do
      url = 'https://raw.githubusercontent.com/pikesley/snake-data/master/length.csv'
      described_class.fetch_CSV(url)
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
  end
end
