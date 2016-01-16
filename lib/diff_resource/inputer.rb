
module DiffResource
	class inputer

		def initialize parser
			@parser = parser
			@resources = []
		end

		def parseFile fileName
			begin
				open fileName do |file|
					resources += parser.parse file.read
				end
			rescue => e
				p e.message
			end
		end

		def inpuFiles dir, extension
			if FileTest.directory? dir then
				dir
			end
		end
	end
end
