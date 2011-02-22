class RedisShelved
  require File.expand_path("../server", __FILE__)

  def initialize(app)
    @app = app
  end

  def call(env)
    if env["PATH_INFO"] =~ /^\/redis/
      env["PATH_INFO"].gsub!(/^\/redis/, '')
      env['SCRIPT_NAME'] = ''
      env['REQUEST_URI'].gsub!(/^\/redis/, '')
      app = Rack::RedisShelfServer.new(:host => "localhost", :db => 7)
      app.call(env)
    else
      @app.call(env)
    end
  end
end
