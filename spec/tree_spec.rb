require "rspec"
require_relative "../lib/tree"
require_relative "../lib/node"

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
        tree.build_tree [5, 2, 3, 4, 1]
        expect(tree.balanced?).to eql true
      end

      it "doesn't assign duplicate values" do
        tree = subject
        tree.build_tree [1, 2, 3, 4, 3, 1, 5]
        expect(tree.inorder.size).to eql 5
      end
    end
  end

  describe "#insert" do
    context "when given an empty tree" do
      it "adds the given node to the tree" do
        tree = subject
        tree.insert 3
        expect(tree.find(3)).to_not be nil
      end
    end

    context "when given a non-empty tree" do
      it "adds the given node to the tree" do
        tree = subject
        tree.build_tree(Array.new(6) { rand(1..50) })
        tree.insert(51)
        expect(tree.find(51)).to_not eql nil
      end

      it "doesn't assign duplicate values" do
        tree = subject
        tree.build_tree [1, 2, 3, 4, 5]
        tree.insert(4)
        expect(tree.inorder.size).to eql 5
      end
    end
  end

  describe "#delete" do
    context "when given an empty list" do
      it "returns nil" do
        expect(subject.delete(3)).to eql nil
      end
    end

    context "when given a non-empty list" do
      before do
        @tree = subject
        @tree.build_tree [1, 2, 3, 4, 5]
      end

      context "when deleting an existing element" do
        it "returns the node data" do
          expect(@tree.remove(4)).to eql 4
        end

        it "removes the node from the tree" do
          @tree.remove 1
          expect(@tree.find(1)).to eql nil
        end

        it "correctly removes and replaces the root node" do
          @tree.remove 3
          expect(@tree.root).to_not eql nil
        end
      end

      context "when deleting a non-existent element" do
        it "returns nil" do
          expect(@tree.remove(10)).to eql nil
        end
      end
    end
  end

  describe "#find" do
    context "when given an empty list" do
      it "returns nil" do
        expect(subject.find(rand(0..100))).to eql nil
      end
    end

    context "when given a non-empty list" do
      before do
        @tree = subject
        @tree.build_tree [1, 2, 3, 4, 5]
      end

      context "when asked for a non-existent value" do
        it "returns nil" do
          expect(@tree.find(11)).to eql nil
        end
      end

      it "returns the node holding the given value" do
        expect(@tree.find(3)).to be_a Node
      end
    end
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
