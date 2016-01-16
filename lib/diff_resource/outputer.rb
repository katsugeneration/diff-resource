
module DiffResource
	class Outputer
		def output diffs, fileName
			begin
				open fileName, "w" do |file|
					file.write "key,value,old,status\n"
					diffs.each do |diff|
						file.write("#{diff.key},#{diff.value},#{diff.old},#{diff.status}\n")
					end
				end
			rescue => e
				p e
			end
		end
	end
end
