require 'redis'

module Rack
	module RedisShelf
		extend self
		F = ::File

		def self.connection
			::Redis.new(:host => self.config['host'], :port => self.config['port'], :db => self.config['db'])
		end

		def self.config
			YAML.load(F.open(
				F.expand_path(F.join(F.dirname(__FILE__), "..", "config", "redis.yml")))
			)
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
