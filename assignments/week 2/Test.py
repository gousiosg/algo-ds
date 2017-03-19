"""Unittest to validate the solution"""

import unittest
from Solution import DoublyLinkedList, Node


class TestNodeMethods(unittest.TestCase):
    """Test the behavior of the Node object"""

    def test_size(self):
        """Test size of DLL"""
        list1 = DoublyLinkedList()
        self.assertEqual(list1.size(), 0)

if __name__ == '__main__':
    unittest.main()
