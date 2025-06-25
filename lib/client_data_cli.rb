require_relative 'client_data'

class ClientDataCLI
  def self.run(args)
    usage = "Usage: client_data [search NAME | find_duplicates]"
    if args.empty? || args.include?('--help') || args.include?('-h')
      puts usage
      exit 1
    end

    command = args.shift
    case command
    when 'search'
      if args.empty?
        puts "Usage: client_data search NAME"
        exit 1
      end
      name = args.join(' ')
      ClientData::Queries::Search.find_by_name(name)
    when 'find_duplicates'
      ClientData::Queries::Duplicates.find_by_email
    else
      puts "Unknown command: #{command}"
      puts usage
      exit 1
    end
  end
end
