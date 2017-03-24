"""Unittest to validate the solution"""

import unittest
from Solution import DoublyLinkedList, Node


class TestNodeMethods(unittest.TestCase):
    """Test the behavior of the Node object"""

    def test_weblab(self):
        """The content of this function can be copied to Weblab"""
        test = self

        node1 = Node('1')
        node2 = Node('2')
        node3 = Node('3')
        node4 = Node('4')

        list1 = DoublyLinkedList()
        test.assertEquals(list1.size(), 0)
        test.assertEquals(list1.is_empty(), True)

        list1.add_first(node1)
        list1.add_last(node2)
        list1.add_first(node3)
        test.assertEquals(list1.size(), 3)
        test.assertEquals(list1.get_first(), node3)
        test.assertEquals(list1.is_empty(), False)


if __name__ == '__main__':
    unittest.main()
