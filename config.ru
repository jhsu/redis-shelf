#\ -s thin -p 9292

$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')
require 'redis-shelf/server'
require 'yaml'

config = YAML.load_file('./config/redis.yml')

use Rack::Static, :urls => ["/favicon"]
use Rack::Static, :urls => ["/css"], :root => "public"
app = Rack::RedisShelfServer.new(config)
run app
