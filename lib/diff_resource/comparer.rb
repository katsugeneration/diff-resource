
module DiffResource
	class Comparer
		@@Diff = Struct.new "Diff", :key, :value, :old, :status

		def initialize new_resources, old_resources
			@diffs = new_resources.map do |new_resource|
				ret = nil
				old_resources.each do |old_resource|
					if new_resource.key == old_resource.key then
						status = (new_resource.value == old_resource.value) ? :completed : :modified
						ret = @@Diff.new(new_resource.key, new_resource.value, old_resource.value, status)
						break
					end
				end
				if ret != nil then
					next ret
				end

				@@Diff.new(new_resource.key, new_resource.value, "", :new)
			end
		end

		attr_reader :diffs
	end
end
