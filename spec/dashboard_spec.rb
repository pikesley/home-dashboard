module Dashboard
  describe Fetcher do
    it 'fetches a CSV', :vcr do
      expect(described_class.get_CSV('pikesley/catface', 'flea-treatment.csv')).to eq (
        [
          ["Date"],
          ["2015-12-03"]
        ]
      )
    end
  end
end
