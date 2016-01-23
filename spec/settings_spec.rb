require 'spec_helper'

describe DiffResource do
	before do
		@settings = DiffResource::Settings.new <<-EOS
types:
  name :
    format: "json"
    root : "data"
    key : "key"
    value : "value"

comparison: "dir"

output: "./dir"
		EOS
	end

	it "load settings" do
		expect(@settings.comparison).to eql("dir")
		expect(@settings.output).to eql("./dir")
		expect(@settings.types["name"]).to eql({
			"format" => "json",
			"root" => "data",
			"key" => "key",
			"value" => "value"
		})
	end

	it "load settings when parse error" do
		settings = DiffResource::Settings.new "k::::"
		expect(settings.comparison).to eql(nil)
		expect(settings.output).to eql(nil)
		expect(settings.types["name"]).to eql(nil)
	end

	it "load settings without Hash" do
		settings = DiffResource::Settings.new <<-EOS
- jjj
- jjj
		EOS
		expect(settings.comparison).to eql(nil)
		expect(settings.output).to eql(nil)
		expect(settings.types["name"]).to eql(nil)
	end
end
