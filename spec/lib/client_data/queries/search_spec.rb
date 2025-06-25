require 'spec_helper'

RSpec.describe ClientData::Queries::Search do
  describe '.find_by_name' do
    let(:file_path) { 'data/clients.json' }

    before do
      allow(File).to receive(:read).with(file_path).and_return(
        '[{"id": 1, "full_name": "Jane Doe"}, {"id": 2, "full_name": "Jane Smith"}]'
      )
    end

    it 'searches for clients by name and returns matching results' do
      expect { described_class.find_by_name('Jane Doe') }.to output(
        /Found 1 client\(s\) matching 'Jane Doe':/
      ).to_stdout
    end

    it 'searches with case insensitive' do
      expect { described_class.find_by_name('jane doe') }.to output(
        /Found 1 client\(s\) matching 'jane doe':/
      ).to_stdout
    end

    it 'matches partial names' do
      expect { described_class.find_by_name('Jane') }.to output(
        /Found 2 client\(s\) matching 'Jane':/
      ).to_stdout
    end

    it 'returns no results if no clients match the name' do
      expect { described_class.find_by_name('Alice') }.to output(
        /No clients found matching 'Alice'/
      ).to_stdout
    end

    it 'returns no results for an empty name' do
      expect { described_class.find_by_name('') }.to output(
        /No clients found matching ''/
      ).to_stdout
    end
  end
end
