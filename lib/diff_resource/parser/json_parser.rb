require 'json'

module DiffResource
	class JsonParser < Parser
		def initialize options = {}
			@root = options[:root] || ""
			@key = options[:key] || ""
			@value = options[:value] || ""
		end

		def parse str
			ret = []

			begin
				json = JSON.parse str
				root = nested_hash_parse json, @root

				root.each do |item|
					key = nested_hash_parse item, @key
					value = nested_hash_parse item, @value
					ret << @@resource.new(key, value)
				end
			rescue => e
				puts e.message
			end

			return ret
		end
	end
end
