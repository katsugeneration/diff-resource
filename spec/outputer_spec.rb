
describe DiffResource do
	it "Create Diff File" do
		diffs = [Struct::Diff.new("key1", "value1", "old1", :new)]
		outputer = DiffResource::Outputer.new
		outputer.output diffs, "./test.csv"

		open "./test.csv" do |file|
			lines = file.readlines
			expect(lines[1]).to eql("#{diffs[0].key},#{diffs[0].value},#{diffs[0].old},#{diffs[0].status}\n")
		end
		File.unlink "./test.csv"
	end

	it "donot create output File" do
		diffs = [Struct::Diff.new("key1", "value1", "old1", :new)]
		outputer = DiffResource::Outputer.new
		outputer.output diffs, "./test/test.csv"

		expect(FileTest.exist?("./test/test.csv")).to be_falsy
	end
end
