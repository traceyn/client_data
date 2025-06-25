module ClientData
  class Client
    attr_reader :id, :full_name, :email

    def initialize(id, full_name, email)
      @id = id
      @full_name = full_name
      @email = email
    end

    def to_s
      "#{full_name} (ID: #{id}, Email: #{email})"
    end

    def self.from_json(json)
      new(json['id'], json['full_name'], json['email'])
    end
  end
end
