require 'thor'

module DiffResource
	class Cli < Thor
		desc "create <directory> <comparison> <file> <type> [<options>]", <<-EOS
create resource diff file
- directory:		resource file root path
- comparison:		compare directory path or git object
- file:			resource file name format
			ex) test.resource, *.resource, *-en.resource
- type:			resource file type
			you set custom type in .diffresource.yml

EOS
		method_option :output, :aliases => "-o", :type => :string, :desc => "output file path."
		method_option :comparison, :aliases => "-c", :enum => %w(dir git), :desc => "comparison target type. other directory or git hash"
		method_option :setting, :aliases => "-s", :default => "./.diffresource.yml", :desc => "setting file path"
		def create target_dir = nil, comparison_target = nil, target_file = nil, target_type = nil
			p target_type
			option = DiffResource::Cli.make_options options, target_type

			parser = DiffResource::ParserFactory.create option[:type]
			inputer = DiffResource::InputerFactory.create "dir"
			comparison_inputer = DiffResource::InputerFactory.create option[:comparison]

			# in git mode, comparison dir is same to new resources and comprison_target is git object
			if option[:comparison] == "git"
				comparison_inputer.reference = comparison_target
				comparison_target = target_dir
			end

			new_resources = inputer.parse_files target_dir, target_file, parser
			old_resources = comparison_inputer.parse_files comparison_target, target_file, parser
			comparer = DiffResource::Comparer.new new_resources, old_resources

			outputer = DiffResource::Outputer.new
			outputer.output comparer.diffs, option[:output]
		end

		def self.load_settings file_name
			begin
				open file_name do |file|
					return DiffResource::Settings.new file
				end
			rescue
				return DiffResource::Settings.new ""
			end
		end

		def self.add_resx_format settings
			settings.types["resx"] = { "format" => "resx", "root" => "data", "key" => "name", "value" => "value" }
			return settings
		end

		def self.make_options options, type
			ret = {}

			settings = DiffResource::Cli.load_settings options[:setting]
			settings = DiffResource::Cli.add_resx_format settings

			ret[:type] = settings.types[type]
			ret[:comparison] = options[:comparison] || settings.comparison || "dir"
			ret[:output] = options[:output] || settings.output || "./diffs.csv"

			return ret
		end
	end
end
