module ClientData
  module Queries
    class Duplicates
      def self.find_by_email
        puts "Searching for clients with duplicate email addresses..."

        clients = ClientData::ClientLoader.load_clients

        grouped_emails = clients.group_by { |client| client.email&.strip&.downcase }
        duplicates = grouped_emails.select { |_, group| group.size > 1 }

        if duplicates.empty?
          puts "No duplicate email addresses found."
        else
          puts "Found duplicate email addresses:"
          duplicates.each do |email, client_group|
            puts "- #{email} (#{client_group.size} occurrences):"
            client_group.each { |client| puts "  - #{client}" }
          end
        end

        duplicates
      end
    end
  end
end
