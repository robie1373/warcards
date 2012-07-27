# -*- encoding: utf-8 -*-
require File.expand_path('../lib/warcards/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["robie"]
  gem.email         = ["robie1373@gmail.com"]
  gem.description   = %q{An addictive game to help slog through flash-card memorization}
  gem.summary       = %q{An addictive game to help slog through flash-card memorization}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "warcards"
  gem.require_paths = ["lib"]
  gem.version       = Cardgame::VERSION

  # specify any dependencies here
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-minitest'
  gem.add_development_dependency 'minitest-spec'
  #gem.add_dependency 'ap'
end
