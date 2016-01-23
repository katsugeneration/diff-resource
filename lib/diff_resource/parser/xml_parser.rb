require 'xmlsimple'

module DiffResource
	class XmlParser < Parser
		def parse str
			ret = super str
			ret.each do |item|
				item.value = item.value[0]
			end
			return ret
		end

		def parse_string str
			return XmlSimple.xml_in str
		end
	end
end
