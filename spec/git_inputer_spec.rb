require 'spec_helper'

describe DiffResource do
	before do
		@parser = double("parser", :parse => [1, 2])
		@inputer = DiffResource::GitInputer.new
		@inputer.reference = "HEAD"
	end

	it "call parser with text contents when Inputer parse file" do
		expect(@parser).to receive(:parse).with("TEST\n")
		@inputer.parse_file './spec/test_file/test.txt', @parser
	end

	it "get resources after call parse_file" do
		ret = @inputer.parse_file './spec/test_file/test.txt', @parser
		expect(ret).to eql([1, 2])
	end

	it "donot call parser when file donot exist" do
		expect(@parser).to receive(:parse).exactly(0).times
		@inputer.parse_file 'None File', @parser
	end

	it "donot call parser when ref donot exist" do
		@inputer.reference = "devel"
		expect(@parser).to receive(:parse).exactly(0).times
		@inputer.parse_file './spec/test_file/test.txt', @parser
	end

	it "add resources when parse_files call" do
		ret = @inputer.parse_files './spec/test_file', 'test.txt', @parser
		expect(ret).to eql([1, 2])
	end

	it "add resources when parse_files with * contained extension" do
		ret = @inputer.parse_files './spec/test_file', '*t.txt', @parser
		expect(ret).to eql([1, 2])
	end

	it "no resources when parse_files with none extension" do
		ret = @inputer.parse_files './spec/test_file', '*.js', @parser
		expect(ret).to eql([])
	end

	it "no resources when parse_files with bad extension" do
		ret = @inputer.parse_files './spec/test_file', '.txt', @parser
		expect(ret).to eql([])
	end

	it "add resources when parse_files call case existing nest folder" do
		ret = @inputer.parse_files './spec/test_file', '*.txt', @parser
		expect(ret).to eql([1, 2, 1, 2])
	end

	it "add resources regardless root directory format" do
		ret = @inputer.parse_files 'spec/', '*.txt', @parser
		expect(ret).to eql([1, 2, 1, 2])
	end
end
