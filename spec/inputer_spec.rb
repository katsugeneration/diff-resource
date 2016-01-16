require 'spec_helper'

describe DiffResource do
	before do
		@parser = double("parser", :parse=>[1, 2])
		@inputer = DiffResource::Inputer.new @parser
	end

	it "Inputer new" do
		inputer = DiffResource::Inputer.new nil
		expect(inputer.parser).to be_nil
	end

	it "call parser with text contents when Inputer parse file" do
		expect(@parser).to receive(:parse).with("TEST\n")
		@inputer.parseFile './spec/test_file/test.txt'
	end

	it "get resources after call parseFile" do
		ret = @inputer.parseFile './spec/test_file/test.txt'
		expect(ret).to eql([1, 2])
	end

	it "donot call parser when file donot exist" do
		expect(@parser).to receive(:parse).exactly(0).times
		@inputer.parseFile 'None File'
	end

	it "add resources when parseFiles call" do
		ret = @inputer.parseFiles './spec/test_file', 'test.txt'
		expect(ret).to eql([1, 2])
	end

	it "no resources when parseFiles none extension" do
		ret = @inputer.parseFiles './spec/test_file', '*.js'
		expect(ret).to eql([])
	end

	it "add resources when parseFiles call case existing nest folder" do
		ret = @inputer.parseFiles './spec/test_file', '*.txt'
		expect(ret).to eql([1, 2, 1, 2])
	end
end
