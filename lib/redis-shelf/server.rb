require 'haml'
require 'rack'

require File.expand_path(File.join(File.dirname(__FILE__), '..', '/rack/redis-shelf'))

module Rack
	class RedisShelfServer
		F = ::File
		def initialize(conf={})
			@shelf = RedisShelf.new(conf)
		end

		def call(env)
			header = {"Content-Type" => "text/html"}
			key = env["REQUEST_URI"]

			key = @shelf.parse(key)
			history(key)
			values, code = @shelf.http_response(key)
			content = render("show", :values => values, :key => key, :history => history, :redis => @shelf.connection)

			[code, header, [content]]
		end

		def view_dir
			F.expand_path(F.join(F.dirname(__FILE__), "..", "..", "/views" ))
		end

		def render(view, opts={})
			::Haml::Engine.new(F.read("#{view_dir}/#{view}.haml")).render(Object.new, opts)
		end

		def history(key=nil)
			if key
				@shelf.connection.lpush("history", key) unless key.empty?
			else
				@shelf.connection.lrange("history",0,10)
			end
		end
	end
end

