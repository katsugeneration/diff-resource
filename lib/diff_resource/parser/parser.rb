
module DiffResource
	class Parser
		@@resource = Struct.new "Resource", :key, :value

		def initialize options = {}
			@root = options[:root] || ""
			@key = options[:key] || ""
			@value = options[:value] || ""
		end

		def nested_hash_access hash, path
			ret = hash
			path.split(".").each do |symbol|
				ret = ret[symbol]
			end

			return ret
		end

		def parse str
			ret = []
			begin
				obj = parse_string str
				root = nested_hash_access obj, @root

				root.each do |item|
					next unless parsre_target? item
					key = nested_hash_access item, @key
					value = nested_hash_access item, @value
					ret << @@resource.new(key, value)
				end
			rescue => e
				puts e.message
			end

			return ret
		end

		def parse_string str
		end

		def parsre_target? item
			return true
		end
	end
end
