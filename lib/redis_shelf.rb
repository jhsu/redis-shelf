$:.unshift(File.expand_path(File.dirname(__FILE__)))
CONFIG_FILE = File.expand_path(File.join(File.dirname(__FILE__), "..", "config", "redis.yml"))

require 'bundler'
Bundler.require(:default)


require 'redis_shelf/redis_connection'
require 'redis_shelf/helpers'
require 'redis_shelf/redis_shelf'
require 'redis_shelf/version'
