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

  def inorder
    stack = [@root]
    values = []
    while stack.size > 0
      current = stack.pop
      if current.is_a? Node
        stack << current.right_node unless current.right_node.nil?
        stack << current.data
        stack << current.left_node unless current.left_node.nil?
      else
        values << current
      end
    end
    values
  end

  def preorder
    stack = [@root]
    values = []
    while stack.size > 0
      current = stack.pop
      values << current.data
      stack << current.right_node unless current.right_node.nil?
      stack << current.left_node unless current.left_node.nil?
    end
    values
  end

  def postorder
    stack = [@root]
    values = []
    while stack.size > 0
      current = stack.pop
      if current.is_a? Node
        stack << current.data
        stack << current.right_node unless current.right_node.nil?
        stack << current.left_node unless current.left_node.nil?
      else
        values << current
      end
    end
    values
  end

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
