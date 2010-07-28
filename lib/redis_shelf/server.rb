require 'bundler'
Bundler.setup(:default)
require 'haml'

require 'redis_shelf'

module Rack
	class RedisShelfServer
		F = ::File
		def call(env)
			header = {"Content-Type" => "text/html"}
			key = env["REQUEST_URI"]

			key = RedisShelf.parse(key)
			history(key)
			values, code = RedisShelf.http_response(key)
			content = render("show", :values => values, :key => key, :redis => RedisShelf.connection)

			[code, header, [content]]
		end

		def render(view, opts={})
			::Haml::Engine.new(F.read("./views/#{view}.haml")).render(Object.new, opts)
		end

	end
end

def history(key=nil)
	if key
		Rack::RedisShelf.connection.lpush("history", key) unless key.empty?
	else
		Rack::RedisShelf.connection.lrange("history",0,10)
	end
end
