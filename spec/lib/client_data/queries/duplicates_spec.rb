require 'spec_helper'
RSpec.describe ClientData::Queries::Duplicates do
  describe '.find_by_email' do
    subject(:find_duplicates) { ClientData::Queries::Duplicates.find_by_email }

    let(:client1) { ClientData::Client.new(1, 'Jane Doe', 'jane.doe@example.com') }
    let(:client2) { ClientData::Client.new(2, 'John Smith', 'john.smith@example.com') }
    let(:client3) { ClientData::Client.new(3, 'Another Jane Doe', 'jane.doe@example.com') }

    context 'when there are no duplicate clients' do
      before do
        allow(ClientData::ClientLoader).to receive(:load_clients).and_return([client1, client2])
      end
      it 'returns an empty array' do
        expect(STDOUT).to receive(:puts).with("Searching for clients with duplicate email addresses...")
        expect(STDOUT).to receive(:puts).with("No duplicate email addresses found.")

        expect(find_duplicates).to be_empty
      end
    end

    context 'when there are duplicate clients' do
      before do
        allow(ClientData::ClientLoader).to receive(:load_clients).and_return([client1, client2, client3])
      end

      it 'returns a hash of of duplicate clients based on email' do
        duplicate_email = 'jane.doe@example.com'
        expect(STDOUT).to receive(:puts).with("Searching for clients with duplicate email addresses...")
        expect(STDOUT).to receive(:puts).with("Found duplicate email addresses:")
        expect(STDOUT).to receive(:puts).with("- #{duplicate_email} (2 occurrences):")
        expect(STDOUT).to receive(:puts).with("  - #{client1}")
        expect(STDOUT).to receive(:puts).with("  - #{client3}")

        duplicates = find_duplicates
        expect(duplicates).to be_a(Hash)
        expect(duplicates).to have_key(duplicate_email)
        expect(duplicates[duplicate_email]).to include(client1, client3)
        expect(duplicates[duplicate_email]).not_to include(client2)
      end
    end
  end
end
