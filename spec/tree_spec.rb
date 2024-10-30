require "rspec"
require_relative "../lib/tree"

RSpec.describe Tree do
  describe "#build-tree" do
    context "when given an array of values of the same type" do
      it "returns the root node" do
        expect(build_tree([3, 4, 5, 1, 2])).to eql 3
      end

      it "assigns the root node to @root" do
        tree = subject
        tree.build_tree([4, 1, 5, 3, 2])
        expect(tree.root).to eql 3
      end

      it "creates a balanced tree" do
        tree = subject
        tree.build_tree([5, 2, 3, 4, 1])
        expect()
      end
    end
  end

  describe "#insert" do
  end

  describe "#delete" do
  end

  describe "#find" do
  end

  describe "#level_order" do
  end

  describe "#inorder" do
  end

  describe "#preorder" do
  end

  describe "#postorder" do
  end

  describe "#height" do
  end

  describe "#depth" do
  end

  describe "#balanced?" do
  end

  describe "#rebalance" do
  end
end
