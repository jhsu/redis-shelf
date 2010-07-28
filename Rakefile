require 'rake'
require 'echoe'

path = File.expand_path("../lib", __FILE__)
$:.unshift(path) unless $:.include?(path)
require "redis_shelf"

Echoe.new('redis-shelf', '0.1.pre') do |p|
	p.description = 'Redis key browser'
	p.url         = 'http://github.com/jhsu/redis-shelf'
	p.version     = Rack::RedisShelf::Version
	p.author      = 'Joseph Hsu'
	p.email       = 'jhsu@josephhsu.com'
end
