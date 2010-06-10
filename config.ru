#\ -s thin -p 3000

require 'bundler'
Bundler.require(:default)

$:.unshift(Dir.pwd)
require 'redis_shelf'


use Rack::Static, :urls => ["/favicon"]
use Rack::Static, :urls => ["/css"], :root => "public"
app = RedisShelf.new
run app
