module Dashboard
  describe Cleaner do
    context 'helpers' do
      it 'titleises a string' do
        expect(described_class.titleise 'vivarium-cleans.csv').to eq 'Vivarium Cleans'
      end
    end
    it 'turns a CSV into a JSON-ish hash', :vcr do
      csv = Fetcher.fetch_CSV 'https://raw.githubusercontent.com/pikesley/snake-data/master/length.csv'
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
      expect(described_class.sanitized_data 'https://api.github.com/repos/pikesley/snake-data/contents/length.csv?ref=master').to eq (
        {
          'title' => 'Length',
          'singular' => 'Length',
          'name' => 'length.csv',
          'url' => 'https://github.com/pikesley/snake-data/blob/master/length.csv',
          'data' => [
            ['Date', 'Length in m'],
            ['2014-09-30', '0.45'],
            ['2014-10-09', '0.50'],
            ['2014-10-18', '0.50'],
            ['2014-12-12', '0.55'],
            ['2015-01-11', '0.60'],
            ['2015-01-28', '0.65'],
            ['2015-08-27', '0.95']
          ]
        }
      )
    end
  end
end
