require 'spec_helper'

describe DiffResource do
	before do
		@parser = DiffResource::JsonParser.new({ "root" => "root.data", "key" => "key", "value" => "value" })
	end

	it "parse json" do
		ret = @parser.parse <<-EOS
{
	"root" :{
		 "data" : [
			 {
				 "key" : "string1",
				"value" : "hello"
			}
		]
	}
}
		EOS

		expect(ret.length).to eql(1)
		expect(ret[0].key).to eql("string1")
		expect(ret[0].value).to eql("hello")
	end

	it "parse json with key value pair" do
		parser = DiffResource::JsonParser.new({ "root" => "root.data", "key" => "*" })
		ret = parser.parse <<-EOS
{
	"root" :{
		 "data" : {
			"string1" : "hello",
			"string2" : "hellohello"
		}
	}
}
		EOS

		expect(ret.length).to eql(2)
		expect(ret[0].key).to eql("string1")
		expect(ret[0].value).to eql("hello")
	end

	it "error occured when parse resx" do
		ret = @parser.parse <<-EOS
{
	"root" :{
		 "data" : [
			 {
				 "key" : "string1",
				"value" : "hello"
			}
	}
}
		EOS

		expect(ret).to eql([])
	end
end
