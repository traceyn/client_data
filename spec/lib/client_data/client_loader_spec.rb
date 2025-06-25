require 'spec_helper'

RSpec.describe 'ClientLoader' do
  let(:client_loader) { ClientData::ClientLoader }

  describe '.load_clients' do
    it 'loads clients from the JSON file' do
      clients = client_loader.load_clients
      expect(clients).to be_an(Array)
      expect(clients.size).to be > 0
      expect(clients.first).to be_a(ClientData::Client)
    end

    it 'returns and empty array if the file does not exist' do
      expect(STDOUT).to receive(:puts).with("Error: File not found - not_a_real_file")
      expect(client_loader.load_clients("not_a_real_file")).to eq([])
    end

    it 'returns an empty array if the file contains invalid JSON' do
      expect(STDOUT).to receive(:puts).with("Error parsing JSON: Invalid JSON")
      allow(JSON).to receive(:parse).and_raise(JSON::ParserError.new("Invalid JSON"))
      expect(client_loader.load_clients).to eq([])
    end
  end
end
