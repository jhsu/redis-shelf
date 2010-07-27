#\ -s thin -p 9292


require './lib/redis_shelf'

use Rack::Static, :urls => ["/favicon"]
use Rack::Static, :urls => ["/css"], :root => "public"
app = Rack::RedisShelf.new
run app
