
module DiffResource
	class Inputer

		def initialize parser
			@parser = parser
			@resources = []
		end

		attr_reader :parser
		attr_accessor :resources

		def parseFile fileName
			ret = []
			begin
				open fileName do |file|
					ret = parser.parse file.read
				end
			rescue => e
				p e.message
			end

			return ret
		end

		def parseFiles path, extension
			if FileTest.directory? path then
				Dir.foreach path do |file|
					next if /^\.+$/ =~ file
					parseFiles File.absolute_path(file, path), extension
				end
			elsif FileTest.file? path then
				if /#{extension.gsub("*.", ".*\.")}$/ =~ path then
					@resources += parseFile path
				end
			end

			return @resources
		end
	end
end
