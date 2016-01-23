require 'yaml'

module DiffResource
	class Settings
		def initialize str
			@options = YAML.load(str)
			@options = {} unless @options.class == Hash # @options is Hash object
			@options["types"] = {} unless @options["types"].class == Hash # @options["types"] is Hash Object
		end

		def types
			return self["types"]
		end

		def comparison
			return self["comparison"]
		end

		def output
			return self["output"]
		end

		def [] key
			return @options[key]
		end
	end
end
