
module DiffResource
	class DirectoryInputer
		def parse_file file_name, parser
			ret = []
			begin
				open file_name do |file|
					ret = parser.parse file.read
				end
			rescue => e
				p e.message
			end

			return ret
		end

		def parse_files path, extension, parser
			resources = []

			if FileTest.directory? path
				Dir.foreach path do |file|
					next if /^\.+$/ =~ file
					resources += parse_files File.absolute_path(file, path), extension, parser
				end
			elsif FileTest.file? path
				resources += parse_file path, parser if %r{^.*\/#{extension}$} =~ path
			end

			return resources
		end
	end
end
