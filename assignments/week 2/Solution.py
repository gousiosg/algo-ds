"""Python implementation of doubly linked list"""
class Node(object):
    """Doubly linked node which stores an object"""
    def __init__(self, item, nextNode, previousNode):
        self.item = item
        self.next = nextNode
        self.previous = previousNode
        