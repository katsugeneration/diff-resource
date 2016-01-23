
module DiffResource
	class ParserFactory
		def self.create type
			return case type["format"]
			when "resx"
				DiffResource::ResxParser.new
			when "json"
				DiffResource::JsonParser.new type
			else
				fail ArgumentError.new, 'undefined parser type'
			end
		end
	end
end
