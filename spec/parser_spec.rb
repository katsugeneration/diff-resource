require 'spec_helper'

describe DiffResource do
	it "parse resx" do
		parser = DiffResource::ResxParser.new
		ret = nil

		open './spec/test_file/test.resx' do |file|
			ret = parser.parse file.read
		end

		expect(ret.length).to eql(1)
		expect(ret[0].key).to eql("string1")
		expect(ret[0].value).to eql("hello")
	end

	it "error occured when parse resx" do
		parser = DiffResource::ResxParser.new
		ret = parser.parse "<xml><undeined xml"

		expect(ret).to eql([])
	end
end
