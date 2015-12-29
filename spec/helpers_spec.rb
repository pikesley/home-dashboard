module Dashboard
  describe Helpers do
    it 'turns a CSV into a JSON-ish hash', :vcr do
      csv = Fetcher.get_CSV 'https://raw.githubusercontent.com/pikesley/snake-data/master/length.csv'
      expect(described_class.jsonise csv).to eq (
        [
          {
            'Date' => '2014-09-30',
            'Length in m' => '0.45'
          },
          {
            'Date' => '2014-10-09',
            'Length in m' => '0.50'
          },
          {
            'Date' => '2014-10-18',
            'Length in m' => '0.50'
          },
          {
            'Date' => '2014-12-12',
            'Length in m' => '0.55'
          },
          {
            'Date' => '2015-01-11',
            'Length in m' => '0.60'
          },
          {
            'Date' => '2015-01-28',
            'Length in m' => '0.65'
          },
          {
            'Date' => '2015-08-27',
            'Length in m' => '0.95'
          }
        ]
      )
    end

    it 'gets the full JSON', :vcr do
      data = Fetcher.list_CSVs('pikesley/catface').first
      require "pry" ; binding.pry
    end
  end
end
