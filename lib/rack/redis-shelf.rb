require 'redis'
require 'yaml'

module Rack
  class RedisShelf
    F = ::File

    attr_accessor :config

    def initialize(conf={})
      redis_config = {'host' => 'localhost', 'port' => 6379, 'db' => 0}.merge(conf)
      self.config = redis_config
    end

    def connection
      @connection ||= ::Redis.new(self.config)
      Thread.current[:redis] ||= ::Redis.new(self.config)
    end

    def available?
      result = connection.get("")
      result.nil? || result ? true : false
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
