require 'thor'

module DiffResource
	class Cli < Thor
		desc "diff_resource create [root directory] [resource file extension]", "create resource diff file"
		def create target_dir = nil, target_file = nil, target_type = nil
			parser = DiffResource::ResxParser.new
			inputer = DiffResource::Inputer.new parser
			new_resources = inputer.parse_files target_dir, target_file

			comparer = DiffResource::Comparer.new new_resources, new_resources
			outputer = DiffResource::Outputer.new
			outputer.output comparer.diffs, "./test.csv"
		end
	end
end
