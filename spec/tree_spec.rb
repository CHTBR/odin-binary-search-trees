require "rspec"
require_relative "../lib/tree"
require_relative "../lib/node"

RSpec.describe Tree do
  let(:random_node) { Node.new(rand(50..100)) }

  describe "#build-tree" do
    context "when given an array of values of the same type" do
      it "returns the root node" do
        expect(subject.build_tree([3, 4, 5, 1, 2])).to eql 3
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
    context "when given an empty tree" do
      it "returns nil" do
        expect(subject.delete(3)).to eql nil
      end
    end

    context "when given a non-empty tree" do
      before do
        @tree = subject
        @tree.build_tree [1, 2, 3, 4, 5]
      end

      context "when deleting an existing element" do
        context "when deleting a leaf node" do
          it "returns the node data" do
            expect(@tree.delete(1)).to eql 1
          end

          it "removes the node from the tree" do
            @tree.delete 1
            expect(@tree.find(1)).to eql nil
          end

          it "preserves all the other elements in the tree" do
            old_elements = @tree.inorder - [1]
            @tree.delete 1
            expect(@tree.inorder.sort).to eql old_elements.sort
          end
        end

        context "when deleting a normal node" do
          it "returns the node data" do
            expect(@tree.delete(4)).to eql 4
          end

          it "removes the node from the tree" do
            @tree.delete 4
            expect(@tree.find(4)).to eql nil
          end

          it "preserves all the other elements in the tree" do
            old_elements = @tree.inorder - [4]
            @tree.delete 4
            expect(@tree.inorder.sort).to eql old_elements.sort
          end
        end

        context "when deleting the root node" do
          it "returns the node data" do
            expect(@tree.delete(3)).to eql 3
          end

          it "removes the root node" do
            @tree.delete 3
            expect(@tree.root).to_not eql 3
          end

          it "replaces the root node with a different node" do
            @tree.delete 3
            expect(@tree.root).to be_a Integer
          end

          it "preserves all the other elements in the tree" do
            old_elements = @tree.inorder - [3]
            @tree.delete 3
            expect(@tree.inorder.sort).to eql old_elements.sort
          end
        end
      end

      context "when deleting a non-existent element" do
        it "returns nil" do
          expect(@tree.delete(10)).to eql nil
        end
      end
    end
  end

  describe "#find" do
    context "when given an empty tree" do
      it "returns nil" do
        expect(subject.find(rand(0..100))).to eql nil
      end
    end

    context "when given a non-empty tree" do
      before do
        @tree = subject
        @tree.build_tree [1, 2, 3, 4, 5]
      end

      context "when asked for a non-existent value" do
        it "returns nil" do
          expect(@tree.find(11)).to eql nil
        end
      end

      context "when asked for a leaf node" do
        it "returns the node holding the given value" do
          expect(@tree.find(5).data).to eql 5
        end
      end

      it "returns the node holding the given value" do
        expect(@tree.find(3).data).to eql 3
      end
    end
  end

  describe "#level_order" do
    before do
      @tree = subject
      @tree.build_tree [1, 2, 3, 4, 5]
      @element_order = [3, 2, 4, 1, 5]
    end

    context "when no block is given" do
      it "returns an array of all the values in the level order" do
        expect(@tree.level_order).to eql @element_order
      end
    end

    it "passes values to the block in the level order" do
      values = []
      @tree.level_order { |value| values << value }
      expect(values).to eql @element_order
    end
  end

  describe "#inorder" do
    before do
      @tree = subject
      @tree.build_tree [1, 2, 3, 4, 5]
      @element_order = [1, 2, 3, 4, 5]
    end

    context "when no block is given" do
      it "returns an array of all the values in the inorder" do
        expect(@tree.inorder).to eql @element_order
      end
    end

    it "passes values to the block in the inorder" do
      values = []
      @tree.inorder { |value| values << value }
      expect(values).to eql @element_order
    end
  end

  describe "#preorder" do
    before do
      @tree = subject
      @tree.build_tree [1, 2, 3, 4, 5]
      @element_order = [3, 2, 1, 4, 5]
    end

    context "when no block is given" do
      it "returns an array of all the values in the preorder" do
        expect(@tree.preorder).to eql @element_order
      end
    end

    it "passes values to the block in the preorder" do
      values = []
      @tree.preorder { |value| values << value }
      expect(values).to eql @element_order
    end
  end

  describe "#postorder" do
    before do
      @tree = subject
      @tree.build_tree [1, 2, 3, 4, 5]
      @element_order = [1, 2, 5, 4, 3]
    end

    context "when no block is given" do
      it "returns an array of all the values in the postorder" do
        expect(@tree.postorder).to eql @element_order
      end
    end

    it "passes values to the block in the postorder" do
      values = []
      @tree.postorder { |value| values << value }
      expect(values).to eql @element_order
    end
  end

  describe "#height" do
    context "when given an empty tree" do
      it "returns nil" do
        expect(subject.height(random_node)).to eql nil
      end
    end

    context "when given a non-empty tree" do
      before do
        @tree = subject
        @tree.build_tree [1, 2, 3, 4, 5]
      end

      context "when asked for a leaf node" do
        it "returns 0" do
          tree = subject
          tree.build_tree [1, 2, 3, 4, 5]
          expect(tree.height(tree.find(5))).to eql 0
        end
      end

      it "returns the height of the root node" do
        expect(@tree.height(@tree.find(3))).to eql 2
      end

      it "returns the height of a node" do
        expect(@tree.height(@tree.find(4))).to eql 1
      end
    end
  end

  describe "#depth" do
    context "when given an empty tree" do
      it "returns nil" do
        expect(subject.depth(random_node)).to eql nil
      end
    end

    context "when given a non-empty tree" do
      before do
        @tree = subject
        @tree.build_tree [1, 2, 3, 4, 5]
      end

      context "when asked for a non-existent value" do
        it "returns nil" do
          expect(@tree.depth(random_node)).to eql nil
        end
      end

      context "when asked for the root node" do
        it "returns 0" do
          expect(@tree.depth(@tree.find(3))).to eql 0
        end
      end

      it "returns the depth of a node" do
        expect(@tree.depth(@tree.find(4))).to eql 1
      end
    end
  end

  describe "#balanced?" do
    context "when given an empty tree" do
      it "returns nil" do
        expect(subject.balanced?).to eql nil
      end
    end

    context "when given a non-empty tree" do
      it "returns true for a tree with 1 element" do
        tree = subject
        tree.insert 1
        expect(tree.balanced?).to eql true
      end

      it "returns true for a balanced tree" do
        tree = subject
        tree.insert 2
        tree.insert 1
        tree.insert 3
        expect(tree.balanced?).to eql true
      end

      it "returns false for an unbalanced tree" do
        tree = subject
        tree.insert 1
        tree.insert 2
        tree.insert 3
        expect(tree.balanced?).to eql false
      end
    end
  end

  describe "#rebalance" do
    before do
      @tree = subject
      @tree.build_tree [1, 2, 3, 4, 5]
      @tree.insert(-1)
      @tree.insert(-7)
      @tree.insert(-19)
      @tree.insert(-16)
    end

    it "returns the new root element" do
      expect(@tree.rebalance).to eql 1
    end

    it "keeps the elements from the unbalanced tree" do
      original_elements = @tree.inorder.sort
      @tree.rebalance
      expect(@tree.inorder.sort).to eql original_elements
    end

    it "creates a balanced tree from an unbalanced tree" do
      expect(@tree.balanced?).to eql false
      @tree.rebalance
      expect(@tree.balanced?).to eql true
    end
  end
end
