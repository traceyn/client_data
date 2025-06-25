require 'spec_helper.rb'

RSpec.describe 'Client' do
  describe '#to_s' do
    it 'returns a string representation of the client' do
      client = ClientData::Client.new(1, 'Jane Doe', 'jane.doe@example.com')
      expect(client.to_s).to eq('Jane Doe (ID: 1, Email: jane.doe@example.com)')
    end
  end

  describe '.from_json' do
    it 'creates a Client instance from a JSON object' do
      json = { 'id' => 1, 'full_name' => 'Jane Doe', 'email' => 'jane.doe@example.com' }
      client = ClientData::Client.from_json(json)
      expect(client).to be_a(ClientData::Client)
      expect(client.id).to eq(1)
      expect(client.full_name).to eq('Jane Doe')
      expect(client.email).to eq('jane.doe@example.com')
    end
  end
end
