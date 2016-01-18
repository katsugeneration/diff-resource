
module DiffResource
	class Parser
		@@resource = Struct.new "Resource", :key, :value

		def nested_hash_parse hash, path
			ret = hash
			path.split(".").each do |symbol|
				ret = ret[symbol]
			end

			return ret
		end
	end
end
