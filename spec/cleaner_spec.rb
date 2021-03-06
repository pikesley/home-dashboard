module Dashboard
  describe Cleaner do
    context 'helpers' do
      it 'titleises an item' do
        expect(described_class.titleise({'name' => 'vivarium-cleans.csv'})).to eq 'Vivarium Clean'
      end

      it 'inverts the lookups' do
        expect(described_class.lookups(inverted = true)).to include (
          {
            'pikesley/snake-data' => {
              'url' => '/snake',
              'title' => 'Snake',
              'repo' => 'pikesley/snake-data',
              'datasets' => {
                'length' => {
                  'type' => 'graph'
                },
                'weight' => {
                  'type' => 'graph'
                },
                'sheds' => {
                  'date-field' => 'Shed completed'
                },
                'feeds' => {
                  'special-fields' => [
                    'Eaten', 'Food'
                  ]
                }
              }
            }
          }
        )
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
          'name' => 'length.csv',
          'id' => 'length',
          'type' => 'graph',
          'source-url' => 'https://github.com/pikesley/snake-data/blob/master/length.csv',
          'data' => [
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
          ],
          'date-field' => 'Date'
        }
      )
    end

    it 'gets simpler JSON', :vcr do
      expect(described_class.sanitized_data 'https://api.github.com/repos/pikesley/catface/contents/flea-treatment.csv?ref=master').to eq (
        {
          'title' => 'Flea Treatment',
          'name' => 'flea-treatment.csv',
          'id' => 'flea-treatment',
          'type' => 'latest',
          'source-url' => 'https://github.com/pikesley/catface/blob/master/flea-treatment.csv',
          'data' => [
            {
              'Date' => '2015-12-03'
            }
          ],
          'date-field' => 'Date'
        }
      )
    end
  end
end
