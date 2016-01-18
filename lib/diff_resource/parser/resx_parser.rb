require 'rexml/document'

module DiffResource
	class ResxParser < Parser
		def parse str
			ret = []
			begin
				resx = REXML::Document.new str

				REXML::XPath.match(resx, "/root/data").map do |data|
					type = data.attribute("type")
					next unless type.nil?

					key = data.attribute("name").value
					value_element = data.elements["value"]
					value = value_element ? value_element.text : nil

					ret << @@resource.new(key, value)
				end
			rescue => e
				puts e.message
			end

			return ret
		end
	end
end
