require File.expand_path("lib/version", File.dirname(__FILE__))

Gem::Specification.new do |spec|
  spec.name        = 'diff_news'
  spec.version     = DiffNews::version
  spec.date        = Date::today.to_s
  spec.summary     = "Tool to keep track of content changes on news sites"
  spec.description = ""
  spec.authors     = ["Thomas Bruderer"]
  spec.email       = 'apophis@apophis.ch'
  spec.files       = Dir['lib/**/*']
  spec.test_files  = Dir['test/*.rb']
  spec.homepage    = 'https://github.com/FreeApophis/DiffNews'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.2'

  spec.add_runtime_dependency 'uuidtools', '~> 2.1', '>= 2.1.5'
  spec.add_runtime_dependency 'nokgiri', '~> 1.8', '>= 1.8.0'

  spec.add_development_dependency "bundler", '~> 1.5', '>= 1.5.0'
  spec.add_development_dependency "rake", '~> 11.0', '>= 11.0.0'
  spec.add_development_dependency "minitest", '~> 5.10', '>= 5.0.0'
  spec.add_development_dependency "minitest-reporters", '~> 1.1', '>= 1.0.0'
end
