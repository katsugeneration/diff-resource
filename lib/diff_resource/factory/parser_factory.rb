
module DiffResource
	class ParserFactory
		def self.create type
			return case type["format"]
			when "resx"
				DiffResource::ResxParser.new
			when "xml"
				DiffResource::XmlParser.new
			when "json"
				DiffResource::JsonParser.new type
			when "yaml"
				DiffResource::YamlParser.new type
			else
				fail ArgumentError.new, 'undefined parser type'
			end
		end
	end
end
