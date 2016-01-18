
module DiffResource
	class Outputer
		def output diffs, file_name
			open file_name, "w" do |file|
				file.write "key,value,old,status\n"
				diffs.each do |diff|
					file.write("#{diff.key},#{diff.value},#{diff.old},#{diff.status}\n")
				end
			end
		rescue => e
			puts e.message
		end
	end
end
