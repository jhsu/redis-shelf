path = File.expand_path("../lib", __FILE__)
$:.unshift(path) unless $:.include?(path)
require "redis_shelf"

Gem::Specification.new do |s|
	s.name			  = 'redis-shelf'
	s.version     = Rack::RedisShelf::Version
	s.date        = '2010-7-27'
	s.summary     = 'Redis key browser'
	s.description = s.summary
	s.files       = Dir['lib/**/*.rb']
	s.has_rdoc    = false
	
	s.author      = 'Joseph Hsu'
	s.email       = 'jhsu@josephhsu.com'
	s.homepage    = 'http://github.com/jhsu/redis-shelf'
end
