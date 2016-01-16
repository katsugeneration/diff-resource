
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

		def inpuFiles dir, extension
			if FileTest.directory? dir then
				Dir.foreach dir do |file|
					if /\.*#{extention}$/.match file
						inputFiles file, extention
					end
				end
			elsif FileTest.file? dir then
				self.resources += parseFile dir
			end
		end
	end
end
