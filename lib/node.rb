# A class for storing basic information needed for a tree and handling comparisons
class Node
  attr_accessor :left_node, :right_node
  attr_reader :data

  def initialize(data); end

  def <=>(other); end
end
