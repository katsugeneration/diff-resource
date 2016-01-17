
module DiffResource
	class Inputer
		def initialize parser
			@parser = parser
			@resources = []
		end

		attr_reader :parser
		attr_accessor :resources

		def parse_file file_name
			ret = []
			begin
				open file_name do |file|
					ret = parser.parse file.read
				end
			rescue => e
				p e
			end

			return ret
		end

		def parse_files path, extension
			if FileTest.directory? path
				Dir.foreach path do |file|
					next if /^\.+$/ =~ file
					parse_files File.absolute_path(file, path), extension
				end
			elsif FileTest.file? path
				if /#{extension.gsub("*.", ".*\.")}$/ =~ path then
					@resources += parse_file path
				end
			end

			return @resources
		end
	end
end
