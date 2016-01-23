require 'json'

module DiffResource
	class JsonParser < Parser
		def parse_string str
			return JSON.parse str
		end
	end
end
