# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'diff_resource/version'

Gem::Specification.new do |spec|
  spec.name          = "diff_resource"
  spec.version       = DiffResource::VERSION
  spec.authors       = ["Katsuya SHIMABUKURO"]
  spec.email         = ["katsu.generation.888@gmail.com"]

  spec.summary       = "Output resource file diffs"
  spec.description   = "Output resource file diffs.You can set resource directory, resource type, output file path, etc..."
  spec.homepage      = "https://github.com/katsugeneration/diff-resource"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |file|
    file =~ %r{^(?:
    spec/.*
    |Gemfile
    |Rakefile
    |\.gitignore
    |\.rubocop.yml
    |\.travis.yml
    )$}x
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '~> 2.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "thor"
end
