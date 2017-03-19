"""Python implementation of doubly linked list"""
class Node(object):

    """Doubly linked node which stores an object"""

    def __init__(self, element, next_node, previous_node):
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
        self.__header = None
        self.__trailer = None

    def size(self):
        """Returns the number of elements in the list"""
        return self.__size

    def is_empty(self):
        """Returns the number of elements in the list"""
        return self.__size == 0

    def get_first(self):
        """Get the first element of the list"""
        if self.is_empty():
            raise Exception('List is empty')
        else:
            return self.__header.get_next()

    def get_last(self):
        """Get the last element of the list"""
        if self.is_empty():
            raise Exception('List is empty')
        else:
            return self.__trailer.get_previous()
