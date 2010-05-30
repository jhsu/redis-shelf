#\ -s thin -p 3000
require 'rack'

$:.unshift(Dir.pwd)
require 'app'


use Rack::Static, :urls => ["/favicon"]
app = Fetcher.new
run app
