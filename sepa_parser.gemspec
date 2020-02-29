# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sepa_parser/version'

Gem::Specification.new do |spec| # rubocop:disable BlockLength
  spec.name = 'sepa_parser'
  spec.version = SepaParser::VERSION
  spec.authors = ['Ruben Smit', 'Martijn Bolhuis']
  spec.email = 'developers@compliance-innovations.com'

  spec.summary = 'Parse ISO20022 XML messages containing SEPA Customer Credit Transfer Initiation messages.'
  spec.description = 'Parse ISO20022 XML messages containing SEPA Customer Credit Transfer Initiation messages.
Currently pain.001.001.03 is supported.'
  spec.homepage = 'https://github.com/compliance-innovations/sepa_parser'
  spec.license = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/compliance-innovations/sepa_parser'
  spec.metadata['changelog_uri'] = 'https://github.com/compliance-innovations/sepa_parser/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rexml'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.69'
  spec.add_development_dependency 'rubocop-performance', '~> 1.3.0'
  spec.add_development_dependency 'rubocop-rails', '~> 2.1'
end
