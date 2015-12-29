module Dashboard
  describe Fetcher do
    context 'fetch CSVs' do
      it 'fetches a simple CSV', :vcr do
        expect(described_class.fetch_CSV('https://raw.githubusercontent.com/pikesley/catface/master/flea-treatment.csv')).to eq (
          [
            ["Date"],
            ["2015-12-03"]
          ]
        )
      end

      it 'fetches a richer CSV', :vcr do
        expect(described_class.fetch_CSV('https://raw.githubusercontent.com/pikesley/snake-data/master/length.csv')).to eq (
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
    end

    context 'assemble metadata + data' do
      it 'fetches the full metadata for a CSV', :vcr do
        expect(described_class.fetch_metadata(
          'https://api.github.com/repos/pikesley/catface/contents/flea-treatment.csv?ref=master')).to eq (
          {
            'name' => 'flea-treatment.csv',
            'path' => 'flea-treatment.csv',
            'sha' => '9f9077ece2431879f7b865ded46ce9796fc17dac',
            'size' => 16,
            'url' => 'https://api.github.com/repos/pikesley/catface/contents/flea-treatment.csv?ref=master',
            'html_url' => 'https://github.com/pikesley/catface/blob/master/flea-treatment.csv',
            'git_url' => 'https://api.github.com/repos/pikesley/catface/git/blobs/9f9077ece2431879f7b865ded46ce9796fc17dac',
            'download_url' => 'https://raw.githubusercontent.com/pikesley/catface/master/flea-treatment.csv',
            'type' => 'file',
            'content' => "RGF0ZQoyMDE1LTEyLTAzCg==\n",
            'encoding' => 'base64',
            '_links'=>{
              'self' => 'https://api.github.com/repos/pikesley/catface/contents/flea-treatment.csv?ref=master',
              'git' => 'https://api.github.com/repos/pikesley/catface/git/blobs/9f9077ece2431879f7b865ded46ce9796fc17dac',
              'html' => 'https://github.com/pikesley/catface/blob/master/flea-treatment.csv'
            }
          }
        )
      end

      it 'adds the CSV data into the metadata', :vcr do
        expect(described_class.assemble_data(
          'https://api.github.com/repos/pikesley/catface/contents/worm-treatment.csv?ref=master')).to eq (
          {
            'name' => 'worm-treatment.csv',
            'path' => 'worm-treatment.csv',
            'repo' => 'catface',
            'sha' => 'd230ca31f494a00dd2efbdf8f64273f991c388a6',
            'size' => 16,
            'url' => 'https://api.github.com/repos/pikesley/catface/contents/worm-treatment.csv?ref=master',
            'html_url' => 'https://github.com/pikesley/catface/blob/master/worm-treatment.csv',
            'git_url' => 'https://api.github.com/repos/pikesley/catface/git/blobs/d230ca31f494a00dd2efbdf8f64273f991c388a6',
            'download_url' => 'https://raw.githubusercontent.com/pikesley/catface/master/worm-treatment.csv',
            'type' => 'file',
            'content' => "RGF0ZQoyMDE1LTEyLTA3Cg==\n",
            'data' => [
              ['Date'],
              ['2015-12-07']
            ],
            'encoding' => 'base64',
            '_links' => {
              'self' => 'https://api.github.com/repos/pikesley/catface/contents/worm-treatment.csv?ref=master',
              'git' => 'https://api.github.com/repos/pikesley/catface/git/blobs/d230ca31f494a00dd2efbdf8f64273f991c388a6',
              'html' => 'https://github.com/pikesley/catface/blob/master/worm-treatment.csv'
            }
          }
        )
      end
    end

    context 'query Github' do
      it 'lists the CSVs in a repo', :vcr do
        expect(described_class.list_CSVs('pikesley/catface').count).to eq 2
        expect(described_class.list_CSVs('pikesley/catface').first).to eq 'https://api.github.com/repos/pikesley/catface/contents/flea-treatment.csv?ref=master'
      end

      it 'gets all the CSVs in a repo', :vcr do
        expect(described_class.fetch_CSVs('pikesley/snake-data').count).to eq 5
        expect(described_class.fetch_CSVs('pikesley/snake-data').first['name']).to eq 'feeds.csv'
        expect(described_class.fetch_CSVs('pikesley/snake-data').last['data']).to be_an Array
        expect(described_class.fetch_CSVs('pikesley/snake-data').first['data'].first).to eq (
          ["Date", "Food", "Offered", "Eaten"]
        )
      end
    end

    it 'extracts a repo name' do
      expect(described_class.extract_repo 'https://api.github.com/repos/pikesley/catface/contents/flea-treatment.csv?ref=master').to eq (
        'catface'
      )
    end
  end
end
