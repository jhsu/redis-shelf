module RedisShelf
	class Connection
		def self.connection
			::Redis.new(self.configuration)
		end

		def self.configuration(conf=nil)
			@configuration = {}
			YAML.load(File.open(CONFIG_FILE)).each do |key, value|
				@configuration[key.to_sym] = value
			end
			@configuration
		end

		def self.parse(key)
			if key.empty?
				""
			else
				key.gsub(/^\/|\/$/,'').gsub(/[\s]+/,'').gsub('/',':')
			end
		end

		def self.fetch(key)
			key = parse(key)
			if !key.empty?
				case self.connection.type(key)
				when "string" || "none"
					connection.get(key) || ""
				when "list"
					connection.lrange(key, 0, -1)
				else
					""
				end
			else
				""
			end
		end

		def self.http_response(key)
			value = fetch(key)
			code = value ? 200 : 404
			[value, code]
		end
	end
end
