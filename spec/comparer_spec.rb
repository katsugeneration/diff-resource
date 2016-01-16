require 'spec_helper'

describe DiffResource do
	@@Resource = Struct.new "Resource", :key, :value

	it "check compare result case same key and value resource" do
		new_resources = [@@Resource.new("test", "new")]
		old_resources = [@@Resource.new("test", "new")]
		comparer = DiffResource::Comparer.new new_resources, old_resources

		expect(comparer.diffs.length).to eql(1)
		expect(comparer.diffs[0].key).to eql("test")
		expect(comparer.diffs[0].value).to eql("new")
		expect(comparer.diffs[0].old).to eql("new")
		expect(comparer.diffs[0].status).to eql(:completed)
	end

	it "check compare result case same key and different value resource" do
		new_resources = [@@Resource.new("test", "new")]
		old_resources = [@@Resource.new("test", "old")]
		comparer = DiffResource::Comparer.new new_resources, old_resources

		expect(comparer.diffs.length).to eql(1)
		expect(comparer.diffs[0].key).to eql("test")
		expect(comparer.diffs[0].value).to eql("new")
		expect(comparer.diffs[0].old).to eql("old")
		expect(comparer.diffs[0].status).to eql(:modified)
	end

	it "check compare result case differenr key resource" do
		new_resources = [@@Resource.new("test", "new")]
		old_resources = [@@Resource.new("differ", "old")]
		comparer = DiffResource::Comparer.new new_resources, old_resources

		expect(comparer.diffs.length).to eql(1)
		expect(comparer.diffs[0].key).to eql("test")
		expect(comparer.diffs[0].value).to eql("new")
		expect(comparer.diffs[0].old).to eql("")
		expect(comparer.diffs[0].status).to eql(:new)
	end

	it "mix pattern" do
		new_resources = [@@Resource.new("test1", "new"), @@Resource.new("test2", "new"), @@Resource.new("test3", "new")]
		old_resources = [@@Resource.new("test1", "new"), @@Resource.new("test2", "old"), @@Resource.new("test3_differ", "old")]
		comparer = DiffResource::Comparer.new new_resources, old_resources

		expect(comparer.diffs.length).to eql(3)

		expect(comparer.diffs[0].key).to eql("test1")
		expect(comparer.diffs[0].value).to eql("new")
		expect(comparer.diffs[0].old).to eql("new")
		expect(comparer.diffs[0].status).to eql(:completed)

		expect(comparer.diffs[1].key).to eql("test2")
		expect(comparer.diffs[1].value).to eql("new")
		expect(comparer.diffs[1].old).to eql("old")
		expect(comparer.diffs[1].status).to eql(:modified)

		expect(comparer.diffs[2].key).to eql("test3")
		expect(comparer.diffs[2].value).to eql("new")
		expect(comparer.diffs[2].old).to eql("")
		expect(comparer.diffs[2].status).to eql(:new)
	end
end
