class RedisHandler
  def self.connection
    Thread.current[:redis_connection] ||= new_connection
  end

  def self.new_connection
    ::Redis.new(self.configuration)
  end

  def self.configuration(conf=nil)
    if conf
      @configuration = conf
    end
    @configuration ||= begin
      YAML.load(File.open("config/redis.yml"))
    end
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
	    connection.get(key)
	  when "list"
	    connection.lrange(key, 0, -1).inject("") {|response, item| response.empty? ? "" : response << "\n"; response << item; response }
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
