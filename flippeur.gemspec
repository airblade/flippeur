# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flippeur/version'

Gem::Specification.new do |gem|
  gem.name          = "flippeur"
  gem.version       = Flippeur::VERSION
  gem.authors       = ["Andy Stewart"]
  gem.email         = ["boss@airbladesoftware.com"]
  gem.description   = %q{Simple feature flipping.}
  gem.summary       = %q{Simple feature flipping.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
