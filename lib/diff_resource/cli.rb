require 'thor'

module DiffResource
	class Cli < Thor
		desc "create [directory] [comparison] [file] <options>", <<-EOS
create resource diff file
- directory:		resource file root path
- comparison:		compare directory path or git hash
- file:			resource file name format
			ex) test.resource, *.resource, *-en.resource

EOS
		method_option :type, :aliases => "-t", :enum => %w(resx), :required => true, :desc => "resource file type"
		method_option :output, :aliases => "-o", :type => :string, :default => "./diffs.csv", :desc => "output file path."
		method_option :compare, :aliases => "-c", :enum => %w(dir git), :default => "dir", :desc => "comparison target type. other directory or git hash"
		def create target_dir = nil, comparison_target = nil, target_file = nil
			parser = DiffResource::ParserFactory.create options[:type]
			inputer = DiffResource::Inputer.new
			comparison_inputer = DiffResource::InputerFactory.create options[:compare]

			new_resources = inputer.parse_files target_dir, target_file, parser
			old_resources = comparison_inputer.parse_files comparison_target, target_file, parser

			comparer = DiffResource::Comparer.new new_resources, old_resources
			outputer = DiffResource::Outputer.new
			outputer.output comparer.diffs, options[:output]
		end
	end
end
