module DiffResource
	class InputerFactory
		def self.create type
			return case type
			when "dir"
				DiffResource::DirectoryInputer.new
			else
				fail ArgumentError.new, 'undefined parser type'
			end
		end
	end
end
