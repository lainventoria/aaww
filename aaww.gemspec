# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aaww/version'

Gem::Specification.new do |spec|
  spec.name          = 'aaww'
  spec.version       = Aaww::VERSION
  spec.authors       = ['La Inventoría']
  spec.email         = ['info@lainventoria.com.ar']
  spec.summary       = %q{A simple Authentise Wrapper}
  spec.description   = %q{A simple Authentise API Wrapper using HTTParty}
  spec.homepage      = 'http://github.com/lainventoria/aaww'
  spec.license       = 'GPLv3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httmultiparty'
  spec.add_dependency 'activemodel'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'pry'
end
