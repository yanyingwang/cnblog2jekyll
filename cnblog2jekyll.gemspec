# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cnblog2jekyll/version'

Gem::Specification.new do |spec|
  spec.name          = "cnblog2jekyll"
  spec.version       = Cnblog2jekyll::VERSION
  spec.authors       = ["YanyingWang"]
  spec.email         = ["yanyingwang1@gmail.com"]
  spec.summary       = %q{cnblog2jekyll}
  spec.description   = %q{Export cnblog's posts to jekyll}
  spec.homepage      = "https://github.com/yanyingwang/cnblog2jekyll"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
