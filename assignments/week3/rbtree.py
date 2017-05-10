class Enum(set):
    def __getattr__(self, name):
        if name in self:
            return name
        raise AttributeError


NodeColors = Enum(["RED", "BLACK"])


class RBNode:
    def __init__(self, color, key, left, right, parent):
        if color not in Enum.__dict__:
            raise AttributeError("Color %s not supported" % color)

        self.left = left
        self.right = right
        self.parent = parent
        self.key = key
        self.color = color

    def __str__(self):
        return str("(%s)%s" % (self._color, self._key))


class RBTree:
    root = RBNode(NodeColors.BLACK, None)
    nil = RBNode(NodeColors.BLACK, None)
    leaf = nil

    def __init__(self, key):
        self.root.key = key

    def traverse(self):
        """
        Traverse all tree nodes in Depth-First order and return a list of stored keys

        @return A list of all keys in the tree"
        """
        return []

    def search(self, key):
        """
        Search this tree for the given key

        @return: The node containing the key, otherwise Nil
        """
        pass

    def left_rotate(self, x):
        y = x.right
        x.right = y.left

        if y.left != self.nil:
            y.left.parent = x
        y.parent = x.parent
        if x.parent == self.nil:
            self.root = y
        elif x == x.parent.left:
            x.parent._left = y
        else:
            x.parent._right = y
        y._left = x
        x.parent = y

    def rotate_right(self, y):
        pass

    def insert(self, key):
        """
        Add a key to the tree
        :param key: The key to add
        """

        # 1. Insertion step
        # 2. Fix-up/Rebalance step
        pass

    def search(self, z):
        y = self.nil
        x = self.root
        while x != self.nil:
            y = x
            if z.key < x.key:
                x = x.left
            else:
                x = x.right
        return y


def check_rb_tree(self, tree):
    "@return: True, only if tree satisfies all the red-black tree criteria"
    return False
