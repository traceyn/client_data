module ClientData
  module Queries
    class Search
      def self.find_by_name(name)
        if name.nil? || name.strip.empty?
          puts "No clients found matching ''"
          return
        end

        puts "Searching client names for: #{name}"

        clients = ClientData::ClientLoader.load_clients

        results = clients.select do |client|
          client.full_name.downcase.include?(name.downcase)
        end

        if results.empty?
          puts "No clients found matching '#{name}'"
        else
          puts "Found #{results.size} client(s) matching '#{name}':"
          results.each do |client|
            puts "- #{client}"
          end
        end
      end
    end
  end
end
