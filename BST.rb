# A node class for the bst
class BSTNode
    include Comparable

    attr_accessor :left, :right, :item

    def initialize item
        @item = item
    end

    def <=> other
        return @item <=> other.item
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
    def add item
        @root = addHelper item, @root
    end

    ##
    # Returns true if the item has been added to the tree, false otherwise. Checks using the == operator
    def contains item
        return containsHelper item, @root
    end

    ##
    # Removes the value from the tree.  If applicable, replaces with the successor
    def remove item
        @root = removeHelper item, @root
    end 

    ##
    # Returns a preorder traversal of the tree
    def preorder
        ret = Array.new
        preorderHelper @root, ret
        return ret
    end

    ##
    # Returns a preorder traversal of the tree
    def inorder
        ret = Array.new
        inorderHelper @root, ret
        return ret
    end

    ##
    # Returns a postorder traversal of the tree
    def postorder
        ret = Array.new
        postorderHelper @root, ret
        return ret
    end

    private 

    # Recurses through the bst for adding
    def addHelper item, root
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
    def containsHelper item, root
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
    def removeHelper item, root
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

    #Gets the largest item in the subtree
    def getLargest root
        if !root.right
            return root.item
        else
            return getLargest root.right
        end
    end

    def preorderHelper root, arr
        if root
            arr.push root.item
            preorderHelper root.left, arr
            preorderHelper root.right, arr
        end
    end

    def inorderHelper root, arr
        if root
            preorderHelper root.left, arr
            arr.push root.item
            preorderHelper root.right, arr
        end
    end

    def postorderHelper root, arr
        if root
            preorderHelper root.left, arr
            preorderHelper root.right, arr
            arr.push root.item
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
# puts bst.size
# bst.remove 10
# puts bst.size
# puts bst.root.item
puts bst.preorder
# puts bst.contains 10
# puts bst.contains 5
# puts bst.contains 15
# puts bst.contains 143