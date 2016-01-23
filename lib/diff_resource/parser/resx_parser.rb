
module DiffResource
	class ResxParser < XmlParser
		def initialize
			super({ "root" => "data", "key" => "name", "value" => "value" })
		end

		def parsre_target? item
			return nested_hash_access(item, "type").nil?
		end
	end
end
