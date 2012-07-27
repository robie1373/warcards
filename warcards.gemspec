# -*- encoding: utf-8 -*-
require File.expand_path('../lib/warcards/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["robie"]
  gem.email         = ["robie1373@gmail.com"]
  gem.description   = %q{An addictive game of War! to help slog through flash-card memorization}
  gem.summary       = %q{Play a game of War! against the computer. If your card is higher, you get a chance to answer the flash-card question. If you get it correct, you win the round! By the time you win the game, you should really know your stuff!}
  gem.homepage      = "http://robie1373.github.com/warcards"

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
end
