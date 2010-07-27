#\ -s thin -p 9292

require 'bundler'
Bundler.require(:default)

require './lib/redis_shelf'

use Rack::Static, :urls => ["/favicon"]
use Rack::Static, :urls => ["/css"], :root => "public"
app = Rack::RedisShelf.new
run app
