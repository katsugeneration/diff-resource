
module DiffResource
	class Comparer
		@@struct_diff = Struct.new "Diff", :key, :value, :old, :status

		def initialize new_resources, old_resources
			@diffs = new_resources.map do |new_resource|
				ret = nil
				old_resources.each do |old_resource|
					next if new_resource.key != old_resource.key

					status = (new_resource.value == old_resource.value) ? :completed : :modified
					ret = @@struct_diff.new(new_resource.key, new_resource.value, old_resource.value, status)
					break
				end

				unless ret.nil? then next ret end

				@@struct_diff.new(new_resource.key, new_resource.value, "", :new)
			end
		end

		attr_reader :diffs
	end
end
