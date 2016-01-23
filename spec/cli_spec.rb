require 'spec_helper'
require 'diff_resource/cli'
require 'csv'

describe DiffResource do
	it "load settings" do
		settings = DiffResource::Cli.load_settings "spec/test_file/.diffresource.yml"
		expect(settings.comparison).to eql("dir")
		expect(settings.output).to eql("./dir")
		expect(settings.types["json-custom"]).to eql({
			"format" => "json",
			"root" => "data",
			"key" => "key",
			"value" => "value"
		})
	end

	it "load settings without file" do
		settings = DiffResource::Cli.load_settings ""
		expect(settings.comparison).to eql(nil)
		expect(settings.output).to eql(nil)
		expect(settings.types["name"]).to eql(nil)
	end

	it "add resx type" do
		settings = DiffResource::Cli.load_settings ""
		settings = DiffResource::Cli.add_resx_format settings
		expect(settings["types"]["resx"]).to include( "format" => "resx" )
	end

	it "make options without setting and options" do
		options = {:setting => ""}
		ret = DiffResource::Cli.make_options options, "resx"
		expect(ret[:type]).to include( "format" => "resx" )
		expect(ret[:comparison]).to eql("dir")
		expect(ret[:output]).to eql("./diffs.csv")
	end

	it "make options without setting" do
		options = {:setting => "", :comparison => "git", :output => "output"}
		ret = DiffResource::Cli.make_options options, "resx"
		expect(ret[:type]).to include( "format" => "resx" )
		expect(ret[:comparison]).to eql("git")
		expect(ret[:output]).to eql("output")
	end

	it "make options without options" do
		options = {:setting => "spec/test_file/.diffresource.yml"}
		ret = DiffResource::Cli.make_options options, "json-custom"
		expect(ret[:type]).to include( "format" => "json" )
		expect(ret[:comparison]).to eql("dir")
		expect(ret[:output]).to eql("./dir")
	end

	it "make options" do
		options = {:setting => "spec/test_file/.diffresource.yml", :comparison => "git", :output => "output"}
		ret = DiffResource::Cli.make_options options, "json-custom"
		expect(ret[:type]).to include( "format" => "json" )
		expect(ret[:comparison]).to eql("git")
		expect(ret[:output]).to eql("output")
	end

	it "cli option resx" do
		DiffResource::Cli.start %w(create spec HEAD *.resx resx -c git -o spec/output.csv -s spec/test_file/.diffresource.yml)
		CSV.foreach "spec/output.csv" do |row|
			next if row[0] == "key"
			expect(row[3]).to eql("completed")
		end
		File.delete "spec/output.csv"
	end

	it "cli option yaml" do
		DiffResource::Cli.start %w(create spec spec test.yaml yaml-custom -c dir -o spec/output.csv -s spec/test_file/.diffresource.yml)
		CSV.foreach "spec/output.csv" do |row|
			next if row[0] == "key"
			expect(row[3]).to eql("completed")
		end
		File.delete "spec/output.csv"
	end
end
