#\ -s thin -p 9292

$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')
require 'redis-shelf/server'
require 'yaml'

use Rack::Static, :urls => ["/favicon"]
use Rack::Static, :urls => ["/css"], :root => "public"
app = Rack::RedisShelfServer.new(YAML.load_file('./config/redis.yml'))
run app
