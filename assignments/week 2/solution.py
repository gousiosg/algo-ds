"""Python implementation of doubly linked list"""
class Node(object):
    """Doubly linked node which stores an object"""

    def __init__(self, element, next_node=None, previous_node=None):
        self.__element = element
        self.__next_node = next_node
        self.__previous_node = previous_node

    def get_element(self):
        """Returns the element stored in this node"""
        return self.__element

    def get_previous(self):
        """Returns the previous linked node"""
        return self.__previous_node

    def get_next(self):
        """Returns the next linked node"""
        return self.__next_node

    def set_element(self, element):
        """Sets the element stored in this node"""
        self.__element = element

    def set_previous(self, previous_node):
        """Sets the previous linked node"""
        self.__previous_node = previous_node

    def set_next(self, next_node):
        """Sets the next linked node"""
        self.__next_node = next_node

class DoublyLinkedList(object):
    """Doubly linked node data structure"""

    def __init__(self):
        self.__size = 0
        self.__header = Node('Header')
        self.__trailer = Node('Trailer')
        self.__header.set_next(self.__trailer)
        self.__trailer.set_previous(self.__header)
        self.__current = None

    def __iter__(self):
        return self

    def next(self):
        """Standard python iterator method"""
        if self.is_empty() or self.__current == self.__trailer:
            raise StopIteration()
        elif self.__current is None:
            self.__current = self.__header
        self.__current = self.__current.get_next()
        return self.__current

    def map(self, function):
        """Run function on every element in the list"""
        for node in self:
            if node != self.__trailer and node != self.__header:
                node.set_element(function(node.get_element()))

    def size(self):
        """Returns the number of elements in the list"""
        return self.__size

    def is_empty(self):
        """Returns the number of elements in the list"""
        return self.__size == 0

    def get_first(self):
        """Get the first element of the list"""
        if self.is_empty():
            raise Exception("List is empty")
        else:
            return self.__header.get_next()

    def get_last(self):
        """Get the last element of the list"""
        if self.is_empty():
            raise Exception("List is empty")
        else:
            return self.__trailer.get_previous()

    def get_previous(self, node):
        """Returns the node before the given node"""
        if node == self.__header:
            raise Exception("Cannot get the element before the header of this list")
        else:
            return node.get_previous()

    def get_next(self, node):
        """Returns the node after the given node"""
        if node == self.__trailer:
            raise Exception("Cannot get the element after the trailer of this list")
        else:
            return node.get_next()

    def add_before(self, new, existing):
        """Insert the new before existing"""
        previous_existing = self.get_previous(existing)
        new.set_previous(previous_existing)
        new.set_next(existing)
        existing.set_previous(new)
        previous_existing.set_next(new)
        self.__size += 1

    def add_after(self, new, existing):
        """Insert the new after existing"""
        next_existing = self.get_next(existing)
        new.set_previous(existing)
        new.set_next(next_existing)
        existing.set_next(new)
        next_existing.set_previous(new)
        self.__size += 1

    def add_first(self, new):
        """Insert the node at the head of the list"""
        self.add_after(new, self.__header)

    def add_last(self, new):
        """Insert the node at the tail of the list"""
        self.add_before(new, self.__trailer)

    def remove(self, node):
        """Removes the given node from the list"""
        before = self.get_previous(node)
        after = self.get_next(node)
        before.set_next(after)
        after.set_previous(before)
        node.set_next(None)
        node.set_previous(None)
        self.__size -= 1
