module Dashboard
  describe Fetcher do
    context 'fetch CSVs' do
      it 'fetches a simple CSV', :vcr do
        expect(described_class.get_CSV('pikesley/catface', 'flea-treatment.csv')).to eq (
          [
            ["Date"],
            ["2015-12-03"]
          ]
        )
      end

      it 'fetches a richer CSV', :vcr do
        expect(described_class.get_CSV('pikesley/snake-data', 'length.csv')).to eq (
          [
            ["Date", "Length in m"],
            ["2014-09-30", "0.45"],
            ["2014-10-09", "0.50"],
            ["2014-10-18", "0.50"],
            ["2014-12-12", "0.55"],
            ["2015-01-11", "0.60"],
            ["2015-01-28", "0.65"],
            ["2015-08-27", "0.95"]
          ]
        )
      end

      it 'gets the newest line from a CSV', :vcr do
        expect(described_class.newest('pikesley/snake-data', 'feeds.csv')).to eq (
          ["2015-12-23", "Weaned Mouse", "1", "1"]
        )
      end
    end

    context 'query Github' do
      it 'lists the CSVs in a repo', :vcr do
        expect(described_class.list_CSVs('pikesley/catface').count).to eq 2
      end
    end
  end
end
