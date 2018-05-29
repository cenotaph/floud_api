
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'floud_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'floud_api'
  spec.version       = FloudApi::VERSION
  spec.authors       = ['John W. Fail']
  spec.email         = ['john@ptarmigan.fi']

  spec.summary       = 'Gem to wrap calls to the Floud API'
  spec.description   = 'Gem to wrap calls to the Floud API'
  spec.homepage      = 'https://github.com/cenotaph/floud_api'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-hooks'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'minitest-vcr'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'

  spec.add_dependency 'httmultiparty'
  spec.add_dependency 'json'
end
