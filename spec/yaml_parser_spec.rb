require 'spec_helper'

describe DiffResource do
	before do
		@parser = DiffResource::YamlParser.new({ :root => "root.data", :key => "key", :value => "value" })
	end

	it "parse yaml" do
		ret = @parser.parse <<-EOS
root:
  data:
    - key: "string1"
      value: "hello"
		EOS

		expect(ret.length).to eql(1)
		expect(ret[0].key).to eql("string1")
		expect(ret[0].value).to eql("hello")
	end

	it "error occured when parse yaml" do
		ret = @parser.parse <<-EOS
root:
  data::::
    - key: "string1"
    - value: "hello"
		EOS

		expect(ret).to eql([])
	end
end
