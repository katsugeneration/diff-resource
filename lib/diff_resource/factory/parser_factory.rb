
module DiffResource
	class ParserFactory
		def self.create type
			return case type
			when "resx"
				DiffResource::ResxParser.new
			else
				fail ArgumentError.new, 'undefined parser type'
			end
		end
	end
end
