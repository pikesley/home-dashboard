module Dashboard
  describe 'date fixer' do
    it 'parses a date' do
      expect(Dashboard.date_fixer '2015-12-03').to eq '3rd December'
    end
  end
end
