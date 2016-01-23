require 'yaml'

module DiffResource
	class YamlParser < Parser
		def parse_string str
			return YAML.load str
		end
	end
end
