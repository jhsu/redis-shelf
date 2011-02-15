require 'redis'

module Rack
  class RedisShelf
    F = ::File

    attr_accessor :config

    def initialize(conf={})
      self.config = {'host' => "localhost", 'port' => 6379, 'db' => 1}.merge(conf)
    end

    def connection
      Thread.current[:redis] ||= ::Redis.new(self.config)
    end

    def parse(key)
      if key.empty?
        ""
      else
        key.gsub(/^\/|\/$/,'').gsub(/[\s]+/,'').gsub('/',':')
      end
    end

    def fetch(key)
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

    def http_response(key)
      value = fetch(key)
      code = value ? 200 : 404
      [value, code]
    end
  end
end
