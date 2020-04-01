class Node
  include Comparable
  attr_accessor :left_child, :right_child, :value

  def initialize(value=nil)
    @left_child = nil
    @right_child = nil
    @value = value
  end

  def has_children?
    if self.left_child || self.right_child
      return true
    end
  end

  def has_right_child?
    return true if self.right_child
  end

  def has_left_child?
    return true if self.left_child
  end

  def <=>(other)
    self.value <=> other.value
  end
end

class Tree
  include Enumerable
  attr_reader :root
  def initialize(array)
    @root = nil
    array = build_tree(array)
  end

  def tree_builder(node, rec_node=nil)
    if !rec_node.left_child && node.value < rec_node.value
      return rec_node.left_child = node
    elsif !rec_node.right_child && node.value >= rec_node.value
      return rec_node.right_child = node
    else
      node.value < rec_node.value ? tree_builder(node, rec_node.left_child) : tree_builder(node, rec_node.right_child)
    end
  end

  def build_tree(array)
    array.sort!
    array.uniq!
    @root = Node.new(array.slice!(array.length/2))
    array.map! {|item| item = Node.new(item)}
    array.each {|node| tree_builder(node, @root)}
    #for every node in array
        #*use recursion to change current node (current_node = @root, and depending on comparison operation current_node = current_node.left_child || right_child)

        #compare node with root node(current node)
        #if node is >= and right child exists, compare with right children recursively
        #else (if no right child*****BASECASE******)root.right_child = node
        
        #if node is < and left child exists, compare with left child and its children recursively
        #else (if no left child)******BASECASE***** current_node.left_child = node
    @root
  end

  def insert(value)
    new_node = Node.new(value)
    tree_builder(new_node, @root)
  end

  def bfs_print(node=@root)
    queue = []
    output = []
    queue.push(node)

    while(!queue.empty?)
      current = queue.shift

      if current.has_left_child?
        queue.push current.left_child
      end

      if current.has_right_child?
        queue.push current.right_child
      end

      output.push(current.value)
    end

    puts "breadth-first traversal:"
    puts output.join(" ")
  end

  def delete(value, node=@root) #finds value via bfs and deletes
    queue = []
    queue.push(node)
    while !queue.empty?
      current = queue.shift

      if (current.value == value)
        return (
        puts "Deleted node with value #{value}"
        current.value = nil
        current.left_child = nil
        current.right_child = nil
      )end
      if current.has_left_child?
        queue.push current.left_child
      end

      if current.has_right_child?
        queue.push current.right_child
      end
    end
  end

  def find(value, node=@root) #bfs find
    queue = []
    queue.push(node)
    while !queue.empty?
      current = queue.shift
      if (current.value == value)
        return current
        break
      end
      if current.has_left_child?
        queue.push current.left_child
      end

      if current.has_right_child?
        queue.push current.right_child
      end
    end
  end

  def level_order(node=@root) #bfs find
    queue = []
    queue.push(node)
    while !queue.empty?
      current = queue.shift
      yield(current) if block_given?
      if current.has_left_child?
        queue.push current.left_child
      end
      if current.has_right_child?
        queue.push current.right_child
      end
    end
  end

  def preorder(node=@root, &block)
    if !node
      return
    end
    yield(node) if block_given?
    preorder(node.left_child, &block)
    preorder(node.right_child, &block)
  end

  def inorder(node=@root, &block)
    if !node
      return
    end
    yield(node) if block_given?
    inorder(node.left_child, &block)
    inorder(node.right_child, &block)
  end

  def postorder(node=@root, &block)
    if !node
      return
    end
    output = []
    if block_given?
      yield(node) 
    else
      output.push(node.value)
    end
    postorder(node.left_child, &block)
    postorder(node.right_child, &block)
    p output if !block_given?
  end

  def depth(node=@root, counter=0)
    if !node
      return counter
    end
    x = depth(node.left_child, counter + 1)
    y = depth(node.right_child, counter + 1)
    x > y ? x : y
  end

  def balanced?
    x = depth(self.root.left_child)
    y = depth(self.root.right_child)
    x - y <= 1 && y - x <= 1 ? true : false
  end
end

def rebalance!(tree)
  if !tree.balanced?
    tree_values = []
    tree.level_order do |i|
      tree_values << i.value
    end
    tree = Tree.new(tree_values)
  else
    puts "Tree is already balanced."
  end
end

tree = Tree.new([15,100,4,6,102,99,103,104,105,106])

puts "postorder"
tree.postorder{|i| puts i.value}
puts tree.depth
puts tree.balanced?
puts tree.balanced?
puts ""
puts "tree in level_order"
tree.level_order{|i| puts i.value}
puts "tree in preorder"
puts tree.preorder {|i| puts i.value}
rebalance!(tree)