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
  spec.description   = "Output resource file diffs.You can set resource directory, resource type, output file path."
  spec.homepage      = "https://github.com/katsugeneration/diff-resource"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
