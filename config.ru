#\ -s thin -p 9292

$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')
require 'redis-shelf/server'

use Rack::Static, :urls => ["/favicon"]
use Rack::Static, :urls => ["/css"], :root => "public"
app = Rack::RedisShelfServer.new(:host => "localhost", :port => 6379, :db => 7)
run app
