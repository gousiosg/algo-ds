"""Unittest to validate the solution"""

import unittest
from Solution import DoublyLinkedList, Node


class TestNodeMethods(unittest.TestCase):
    """Test the behavior of the Node object"""

    def weblab_test(self):
        """The content of this function can be copied to Weblab"""
        test = self
        
        list1 = DoublyLinkedList()
        test.assertEquals(list1.size(), 0)

if __name__ == '__main__':
    unittest.main()
