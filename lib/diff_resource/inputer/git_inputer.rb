require 'pathname'
module DiffResource
	class GitInputer
		attr_accessor :reference

		def parse_file file_name, parser
			ret = []

			contents = `git show #{reference}:#{file_name}`
			ret = parser.parse contents if $?.exitstatus == 0
			return ret
		end

		def parse_files path, extension, parser
			resources = []

			if directory? path
				contents = `git ls-tree --name-only #{reference}:#{path}`
				contents.split("\n").each do |file|
					base = Pathname.getwd
					file_path = Pathname(File.expand_path(file, path)).relative_path_from(base).to_s
					resources += parse_files file_path, extension, parser
				end
			elsif file? path
				resources += parse_file path, parser if %r{^.*\/#{extension}$} =~ path
			end

			return resources
		end

		def directory? path
			return type? path, "tree"
		end

		def file? path
			return type? path, "blob"
		end

		def type? path, type
			type_str = `git cat-file -t #{reference}:#{path}`
			return type_str.delete("\n") == type if $?.exitstatus == 0
			return false
		end
	end
end
