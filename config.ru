#\ -s thin -p 3000
require 'rack'

$:.unshift(Dir.pwd)
require 'redis_shelf'


use Rack::Static, :urls => ["/favicon"]
app = RedisShelf.new
run app
