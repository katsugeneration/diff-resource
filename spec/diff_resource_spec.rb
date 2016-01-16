require 'spec_helper'

describe DiffResource do
	before do
		@parser = double("parser", :parse=>[1, 2])
	end

	it "Inputer new" do
		inputer = DiffResource::Inputer.new nil
		expect(inputer.parser).to be_nil
	end

	it "call parser with text contents when Inputer parse file" do
		expect(@parser).to receive(:parse).with("TEST\n")

		inputer = DiffResource::Inputer.new @parser
		inputer.parseFile './spec/test_file/test.txt'
	end

	it "get resources after call parseFile" do
		inputer = DiffResource::Inputer.new @parser
		ret = inputer.parseFile './spec/test_file/test.txt'
		expect(ret).to eql([1, 2])
	end

	it "donot call parser when file donot exist" do
		inputer = DiffResource::Inputer.new @parser
		expect(@parser).to receive(:parse).exactly(0).times
		inputer.parseFile 'None File'
	end
end
