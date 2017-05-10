"""Unittest to validate the solution"""

import unittest
from solution import DoublyLinkedList, Node


class TestNodeMethods(unittest.TestCase):
    """Test the behavior of the Node object"""

    def test_weblab(self):
        """The content of this function can be copied to Weblab"""
        test = self

        node1 = Node(1)
        node2 = Node(2)
        node3 = Node(3)
        node4 = Node(4)
        node5 = Node(5)

        list1 = DoublyLinkedList()
        test.assertEquals(list1.size(), 0)
        test.assertEquals(list1.is_empty(), True)
        test.assertRaises(Exception, list1.get_first)
        test.assertRaises(Exception, list1.get_last)

        list1.add_first(node1)
        list1.add_last(node2)
        list1.add_first(node3)
        test.assertEquals(list1.size(), 3)
        test.assertEquals(list1.get_first(), node3)
        test.assertEquals(list1.get_last(), node2)
        test.assertEquals(list1.is_empty(), False)

        list1.add_after(node4, node1)
        list1.add_before(node5, node3)
        list1.remove(node1)
        test.assertEquals(list1.size(), 4)
        test.assertEquals(list1.get_first(), node5)

        list1.map((lambda x: x **2))
        test.assertEquals(node5.get_element(), 25)

if __name__ == '__main__':
    unittest.main()
