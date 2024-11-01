require_relative "node"

# A class for managing the creation and traversal of a tree DS
class Tree
  def initialize(arr = [])
    build_tree arr if arr.size > 0
  end

  def build_tree(arr)
    arr = arr.uniq.sort
    @root = _build_tree(arr, 0, arr.size - 1)
    @root.data
  end

  def insert(value_or_node)
    if value_or_node.is_a? Node
      value = value_or_node.data
      new_node = value_or_node
    else
      value = value_or_node
      new_node = Node.new(value)
    end
    return @root = new_node if _empty_tree?

    current = @root
    until current.left_node.nil? && current.right_node.nil?
      if current.data > value && !current.left_node.nil?
        current = current.left_node
      elsif current.data < value && !current.right_node.nil?
        current = current.right_node
      else
        break
      end
    end

    if current.data < value
      current.right_node = new_node
    elsif current.data > value
      current.left_node = new_node
    else
      return current
    end

    nil
  end

  def delete(value)
    return nil if _empty_tree?

    current_node = @root
    parent_node = nil
    until current_node.left_node.nil? && current_node.right_node.nil?
      if current_node.data > value && !current_node.left_node.nil?
        parent_node = current_node
        current_node = current_node.left_node
      elsif current_node.data < value && !current_node.right_node.nil?
        parent_node = current_node
        current_node = current_node.right_node
      else
        break
      end
    end

    return nil if current_node.data != value

    deleted_node = current_node
    if parent_node.nil? 
      @root = nil
    elsif !parent_node.left_node.nil? && parent_node.left_node == deleted_node
      parent_node.left_node = nil
    else
      parent_node.right_node = nil
    end

    insert(deleted_node.left_node) unless deleted_node.left_node.nil?
    insert(deleted_node.right_node) unless deleted_node.right_node.nil?

    deleted_node.data
  end

  def find(value)
    return nil if _empty_tree?

    current = @root
    return current if current.data == value
    until current.left_node.nil? && current.right_node.nil?
      if current.data > value && !current.left_node.nil?
        current = current.left_node
      elsif current.data < value && !current.right_node.nil?
        current = current.right_node
      else
        return current
      end
    end
    return current if current.data == value

    nil
  end

  def level_order
    queue = [@root]
    values = []
    while queue.size > 0 do
      current = queue.shift
      values << current.data
      yield current.data if block_given?
      queue << current.left_node unless current.left_node.nil?
      queue << current.right_node unless current.right_node.nil?
    end
    values
  end

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
        yield current if block_given?
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
      yield current.data if block_given?
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
        yield current if block_given?
      end
    end
    values
  end

  def height(node)
    return nil if _empty_tree?
    left_height = node.left_node.nil? ? (-1) : height(node.left_node)
    right_height = node.right_node.nil? ? (-1) : height(node.right_node)
    [left_height, right_height].max + 1
  end

  def depth(node)
    return nil if _empty_tree?

    current = @root
    depth = 0
    until current.left_node.nil? && current.right_node.nil?
      if current.data > node.data && !current.left_node.nil?
        current = current.left_node
      elsif current.data < node.data && !current.right_node.nil?
        current = current.right_node
      else
        return depth
      end
      depth += 1
    end

    nil
  end

  def balanced?
    return nil if _empty_tree?

    _balanced?(@root)[0]
  end

  def rebalance
    data = inorder
    build_tree data
  end

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

  def _balanced?(root)
    left_tree = root.left_node.nil? ? [true, 0] : _balanced?(root.left_node)
    right_tree = root.right_node.nil? ? [true, 0] : _balanced?(root.right_node)
    [left_tree[0] && right_tree[0] && (right_tree[1] - left_tree[1]).abs <= 1, [left_tree[1], right_tree[1]].max + 1]
  end

  def _empty_tree?
    @root.nil?
  end
end
