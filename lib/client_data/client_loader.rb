require 'json'

module ClientData
  class ClientLoader
    CLIENT_DATA_FILE = 'data/clients.json'

    def self.load_clients(file_path = CLIENT_DATA_FILE)
      content = File.read(file_path)
      clients_data = JSON.parse(content)

      clients_data.map do |client_data|
        Client.from_json(client_data)
      end
    rescue Errno::ENOENT
      puts "Error: File not found - #{file_path}"
      []
    rescue JSON::ParserError => e
      puts "Error parsing JSON: #{e.message}"
      []
    end
  end
end
