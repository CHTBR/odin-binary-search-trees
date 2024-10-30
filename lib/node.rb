# A class for storing basic information needed for a tree and handling comparisons
class Node
  include Comparable

  attr_accessor :left_node, :right_node
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def <=>(other)
    data <=> other.data
  end
end
