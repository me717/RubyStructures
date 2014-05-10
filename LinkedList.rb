class LLNode
    attr_accessor :next, :item

    def initialize item
        @item = item
        @next = nil
    end
end

##
# A singly linked list with head and tail pointers
class LinkedList
    attr_accessor :size

    ##
    #initializes the list with size 0 and no head or tail
    def initialize
        @size = 0
        @head = nil
        @tail = nil
    end

    ##
    # Returns the first item in the list
    def first
        return @head.item
    end

    ##
    # Returns the last item in the list
    def last
        return @tail.item
    end

    def toArray
        ret = Array.new @size
        on = 0
        node = @head
        while node
            ret[on] = node.item
            node = node.next
            on += 1
        end
        return ret
    end
    ##
    # Adds an item to the front of the list in O(1)
    def addToFront item
        #if list is empty
        addHelper item do |i|
            node = LLNode.new i
            node.next = @head
            @head = node
        end
    end

    ##
    # Adds an item to the back of the list in O(1)
    def addToBack item
        addHelper item do |i|
            node = LLNode.new i
            @tail.next = node
            @tail = node
        end
    end

    def removeFromFront
        if @head
            @head = head.next
            if size == 1
                @tail = nil
            end
            size -= 1
        end
    end

    def removeFromBack
        if @head
            if size == 1
                @head = nil
                @tail = nil
            else
                node = @head
                while node.next != @tail
                    node = node.next
                end
                @tail = node
                @tail.next = nil
                @size -= 1
            end
        end
    end
    ##
    # Returns whether an item is in the list
    def contains? item
        node = @head
        while node
            if node.item == item
                return true
            end
            node = node.next
        return false
        end
    end

    private

    def addHelper item
        if !@head
            node = LLNode.new item
            @head = node
            @tail = node
        else
            yield item
        end
        @size += 1
    end

end

list = LinkedList.new
list.addToBack 1
list.addToBack 2
list.removeFromBack
list.removeFromBack
puts list.toArray