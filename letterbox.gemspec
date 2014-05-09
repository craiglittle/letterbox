require File.expand_path('../lib/letterbox/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'letterbox'
  spec.version       = Letterbox::VERSION
  spec.authors       = ['Craig Little']
  spec.email         = ['craiglttl@gmail.com']
  spec.description   = %q{Short-lived actor framework using Celluloid}
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/craiglittle/letterbox'
  spec.license       = 'MIT'

  spec.require_paths = ['lib']
  spec.files         = `git ls-files -z`.split('\x0')
  spec.test_files    = spec.files.grep(%r{^spec/})

  spec.add_runtime_dependency 'celluloid', '~> 0.15'

  spec.add_development_dependency 'rake'
end
