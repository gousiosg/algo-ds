"""Python implementation of doubly linked list"""
class Node(object):

    """Doubly linked node which stores an object"""
    def __init__(self, element, next_node, previous_node):
        self.element = element
        self.next_node = next_node
        self.previous_node = previous_node

    def get_element(self):
        """Returns the element stored in this node"""
        return self.element

    def get_previous(self):
        """Returns the previous linked node"""
        return self.previous_node

    def get_next(self):
        """Returns the next linked node"""
        return self.next_node

    def set_element(self, element):
        """Sets the element stored in this node"""
        self.element = element

    def set_previous(self, previous_node):
        """Sets the previous linked node"""
        self.previous_node = previous_node

    def set_next(self, next_node):
        """Sets the next linked node"""
        self.next_node = next_node
    