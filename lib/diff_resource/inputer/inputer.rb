
module DiffResource
	class Inputer
		def match? extension, path
			return %r{^.*\/#{extension}$} =~ path
		end
	end
end
