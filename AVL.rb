# A node class for the bst
class BSTNode
    include Comparable

    attr_accessor :left, :right, :height, :bf, :item

    def initialize item
        @item = item
        @left = nil
        @right = nil
        @bf = 0;
        @height = 1;
    end

    def <=> other
        return @item <=> other.item
    end
end

##
# A self-balancing search tree class.  Will work using standard comparison operators (<, >, ==)
class AVL

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
    def contains? item
        return containsHelper item, @root
    end

    ##
    # Removes the value from the tree.  If applicable, replaces with the successor
    def remove item
        @root = removeHelper item, @root
    end 

    ##
    # Emptys the tree
    def clear!
        @root = nil
        @size = 0
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

    #Updates the height and balance factors of the node.  Leaves have a height of 1
    def update root
        if root.left
            leftHeight = root.left.height
        else 
            leftHeight = 0
        end

        if root.right
            rightHeight = root.right.height
        else 
            rightHeight = 0
        end

        root.height = [leftHeight, rightHeight].max + 1
        root.bf = leftHeight - rightHeight
    end

    #balancing
    def balance root
        if root.bf > 1
            if root.left root.left.bf < 0
                root.left = rotateLeft root.left
            end
            return rotateRight root
        elsif root.bf < -1
            if root.right && root.right.bf > 0
                root.left = rotateRight root.left
            end
            return rotateLeft root
        end

        return root
    end

    def rotateRight root
        newRoot = root.left
        root.left = newRoot.right
        newRoot.right = root
        update root
        update newRoot
        return newRoot
    end

    def rotateLeft root
        newRoot = root.right
        root.right = newRoot.left
        newRoot.left = root
        update root
        update newRoot
        return newRoot
    end
    # Recurses through the bst for adding
    def addHelper item, root
        if !root
            @size = @size + 1
            return BSTNode.new item
        else
            if item < root.item
                root.left = addHelper item, root.left
                update(root)
                return balance(root)
            elsif item > root.item
                root.right = addHelper item, root.right
                update(root)
                return balance(root)
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
                update root
                return balance root
            elsif item > root.item
                root.right = removeHelper item, root.right
                update root
                return balance root
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
                    update root
                    return balance root
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

avl = AVL.new
avl.add 1
avl.add 2
avl.add 3
avl.add 4
avl.add 5
# avl.remove 1
puts avl.preorder