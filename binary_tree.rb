class Node
  include Comparable
  attr_accessor :left_child, :right_child, :children, :value

  def initialize(value=nil)
    @left_child = nil
    @right_child = nil
    @value = value
    @children = nil
  end

  def has_no_children?
    if !self.left_child &&  !self.right_child
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
  def initialize(array)
    @root = nil
    array = build_tree(array)
    puts array
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
    @root = Node.new(array[0])
    array.uniq!
    array.map! {|item| item = Node.new(item)}
    array[1..-1].each {|item| tree_builder(item, @root)}
    #for every node in array
        #*use recursion to change current node (current_node = @root, and depending on comparison operation current_node = current_node.left_child || right_child)

        #compare node with root node(current node)
        #if node is >= and right child exists, compare with right children recursively
        #else (if no right child*****BASECASE******)root.right_child = node
        
        #if node is < and left child exists, compare with left child and its children recursively
        #else (if no left child)******BASECASE***** current_node.left_child = node
    # array[1..-1].each_with_index do |item, index|
    #   puts "ITEM:#{item} INDEX:#{index}"
    #   if @root.has_no_children?
    #     item >= @root ? @root.right_child = Node.new(item) : @root.left_child = Node.new(item)
    #   end
    # end
    @root
  end

  def insert(value)
    new_node = Node.new(value)
    tree_builder(new_node, @root)
  end

  def to_s(node=@root)
    #recursive method to print child nodes
    #start at root. if left subtree exists, print left subtree
    #print root value
    #if right subtree exists from root, print right subtree
    

    # while !current_node.has_no_children?
    #   puts "\t#{current_node.value}"
    #   puts "\t#{current_node.left_child.value}  #{current_node.right_child.value}"
    #   current_node = current_node.right_child
    # end
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
      yield(current)
      if current.has_left_child?
        queue.push current.left_child
      end

      if current.has_right_child?
        queue.push current.right_child
      end
    end
  end

  def inorder
    
  end

  def preorder
  
  end

  def postorder
  
  end
end
# node1 = Node.new(1)
# node2 = Node.new(2)
# puts node1 < node2
# puts "test2"
# node3 = Node.new("apples")
# nodex = Node.new("Apples")
# node4 = Node.new("bananas")
# node5 = Node.new("carrots")
# puts node3 == nodex
tree = Tree.new([5,7,4,2])
tree.insert(9)
tree.bfs_print
tree.delete(9)
tree.bfs_print

tree.find(7).value = 100
tree.bfs_print
2.times {puts ""}
tree.level_order{|i| i.value = 0}
tree.bfs_print

