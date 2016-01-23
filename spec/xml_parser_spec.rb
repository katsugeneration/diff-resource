require 'spec_helper'

describe DiffResource do
	before do
		@resx_parser = DiffResource::ResxParser.new
		@parser = DiffResource::XmlParser.new({ "root" => "resource", "key" => "key", "value" => "value" })
	end

	it "error occured when parse resx" do
		ret = @parser.parse "<?xml ?><undeined xml"

		expect(ret).to eql([])
	end

	it "parse xml" do
		ret = @parser.parse <<-EOS
<?xml version="1.0" encoding="utf-8"?>
<root>
	<resource key="string1">
		<value>hello</value>
	</resource>
</root>
		EOS

		expect(ret.length).to eql(1)
		expect(ret[0].key).to eql("string1")
		expect(ret[0].value).to eql("hello")
	end

	it "parse resx" do
		ret = nil

		open './spec/test_file/test.resx' do |file|
			ret = @resx_parser.parse file.read
		end

		expect(ret.length).to eql(2)
		expect(ret[0].key).to eql("string1")
		expect(ret[0].value).to eql("hello")
	end
end
