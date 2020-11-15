RSpec.describe FindSharedLines do
  it "has a version number" do
    expect(FindSharedLines::VERSION).not_to be nil
  end

  describe '.read_file_into_set' do
    filepath = 'fixtures/a.txt'

    it 'returns a set' do
      set = FindSharedLines.read_file_into_set(filepath)
      expect(set).to be_a(Set)
    end

    it 'return a set of unique lines' do
      expected = [
        'only in a 1',
        'only in a 2',
        'in a and b 1',
        'in a and b 2',
        'in a and c 1',
        'in a and c 2',
        'in a, b and c 1',
        'in a, b and c 2'
      ].sort

      set = FindSharedLines.read_file_into_set(filepath)

      expect(set.to_a.sort).to eq(expected)
    end
  end
end
