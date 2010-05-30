require 'yaml'
require 'redis'

$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))
require 'redis_handler'

def redis_to_code(response)
  if response.nil?
	404
  else
	200
  end
end

class RedisShelf
  def call(env)
	header = {"Content-Type" => "text/plain"}
    key = env["REQUEST_URI"]
    response, code = RedisHandler.http_response(key)
	[code, header, [key + "\n", response]]
  end
end
