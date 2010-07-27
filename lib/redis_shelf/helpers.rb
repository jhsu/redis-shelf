def render(view, opts={})
	Haml::Engine.new(File.read("./views/#{view}.haml")).render(Object.new, opts)
end

def history(key=nil)
  if key
    RedisShelf::Connection.connection.lpush("history", key) unless key.empty?
  else
    RedisShelf::Connection.connection.lrange("history",0,10)
  end
end
