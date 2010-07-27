module Rack
	class RedisShelf
		Connection = ::RedisShelf::Connection

		def call(env)
			header = {"Content-Type" => "text/html"}
			key = env["REQUEST_URI"]

			key = Connection.parse(key)
			history(key)
			values, code = Connection.http_response(key)
			content = render("show", :values => values, :key => key)

			[code, header, [content]]
		end
	end
end
