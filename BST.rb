# A node class for the bst
class BSTNode
    attr_accessor :left, :right, :item

    def initialize(item)
        @item = item
    end
end

##
# A typical binary search tree class.  Will work using standard comparison operators (<, >, ==)
class BST

    attr_accessor :root, :size

    ##
    # The constructor.  Set size to 0 and root to null
    def initialize
        @root = nil
        @size = 0
    end

    ##
    # Adds the item to the bst
    def add(item)
        @root = addHelper item, @root
    end

    ##
    # Returns true if the item has been added to the tree, false otherwise. Checks using the == operator
    def contains(item)
        return containsHelper item, @root
    end

    ##
    # Removes the value from the tree.  If applicable, replaces with the successor
    def remove(item)
        @root = removeHelper item, @root
    end 

    private 

    # Recurses through the bst for adding
    def addHelper(item, root)
        if !root
            @size = @size + 1
            return BSTNode.new item
        else
            if item < root.item
                root.left = addHelper item, root.left
                return root
            elsif item > root.item
                root.right = addHelper item, root.right
                return root
            else
                return root
            end
        end
    end

    # Recurses through the bst for contains
    def containsHelper(item, root)
        if !root
            return false
        else
            if item < root.item
                return containsHelper item, root.left
            elsif item > root.item
                return containsHelper item, root.right
            else
                return true
            end
        end
    end

    # Recurses through the tree for remove
    def removeHelper(item, root)
        if !root
            return nil
        else
            if item < root.item
                root.left = removeHelper item, root.left
                return root
            elsif item > root.item
                root.right = removeHelper item, root.right
                return root
            else
                #removing leaf
                if !root.left && !root.right
                    @size -= 1
                    return nil
                #no left child
                elsif !root.left
                    @size -= 1
                    return root.right
                #no right child
                elsif !root.right
                    @size -= 1
                    return root.left
                #
                else
                    predecessor = getLargest root.left
                    removeHelper predecessor, root
                    root.item = predecessor
                    return root
                end
            end
        end
    end

    def getLargest(root)
        if(!root.right)
            return root.item
        else
            return getLargest root.right
        end
    end
end

bst = BST.new
bst.add 10
bst.add 15
bst.add 5
bst.add 3
bst.add 7
bst.add 12
bst.add 20
puts bst.size
bst.remove 10
puts bst.size
puts bst.root.item
# puts bst.contains 10
# puts bst.contains 5
# puts bst.contains 15
# puts bst.contains 143

