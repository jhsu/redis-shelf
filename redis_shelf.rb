require 'yaml'
require 'redis'
require 'haml'

$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'views')))
require 'redis_handler'

def render(view, opts={})
	Haml::Engine.new(File.read("./views/#{view}.haml")).render(Object.new, opts)
end

def history(key=nil)
  if key
    RedisHandler.connection.lpush("history", key) unless key.empty?
  else
    RedisHandler.connection.lrange("history",0,10)
  end
end

class RedisShelf
  def call(env)
    header = {"Content-Type" => "text/html"}
    key = env["REQUEST_URI"]

    key = RedisHandler.parse(key)
    history(key)
    values, code = RedisHandler.http_response(key)
    content = render("show", :values => values, :key => key)

    [code, header, [content]]
  end
end
