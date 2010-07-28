# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{redis-shelf}
  s.version = "0.1.pre"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joseph Hsu"]
  s.cert_chain = ["/Users/jhsu/.certs/gem-public_cert.pem"]
  s.date = %q{2010-07-28}
  s.description = %q{Redis key browser}
  s.email = %q{jhsu@josephhsu.com}
  s.extra_rdoc_files = ["LICENSE", "README.mdown", "lib/rack/connection.rb", "lib/rack/redis_shelf.rb"]
  s.files = ["Gemfile", "LICENSE", "Manifest", "README.mdown", "Rakefile", "config.ru", "config/redis.sample.yml", "lib/rack/connection.rb", "lib/rack/redis_shelf.rb", "public/css/style.css", "public/style.css", "views/show.haml", "redis-shelf.gemspec"]
  s.homepage = %q{http://github.com/jhsu/redis-shelf}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Redis-shelf", "--main", "README.mdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{redis-shelf}
  s.rubygems_version = %q{1.3.7}
  s.signing_key = %q{/Users/jhsu/.certs/gem-private_key.pem}
  s.summary = %q{Redis key browser}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
