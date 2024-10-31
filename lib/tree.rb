require_relative "node"

# A class for managing the creation and traversal of a tree DS
class Tree
  def initialize(arr = []); end

  def build_tree(arr)
    arr = arr.uniq.sort
    @root = _build_tree(arr, 0, arr.size - 1)
    @root.data
  end

  def insert(value); end

  def delete(value); end

  def find(value); end

  def level_order; end

  def inorder; end

  def preorder; end

  def postorder; end

  def height(node); end

  def depth(node); end

  def balanced?; end

  def rebalance; end

  def root = @root.data

  private

  def _build_tree(arr, start_index, end_index, direction = "mid")
    mid = start_index + ((end_index - start_index) / 2)
    mid += 1 if end_index - start_index == 1 && direction == "left"
    root = Node.new(arr[mid])
    root.left_node = _build_tree(arr, start_index, mid - 1, "left") unless mid == start_index
    root.right_node = _build_tree(arr, mid + 1, end_index, "right") unless mid == end_index
    root
  end
end
