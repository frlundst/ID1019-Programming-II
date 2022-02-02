defmodule TreeTesting do
    def test do
        tree = Tree.new()
        tree = Tree.insert(2, 10, tree)
        tree = Tree.insert(3, 11, tree)
        tree = Tree.insert(4, 12, tree)
        tree = Tree.insert(7, 13, tree)
        tree = Tree.insert(6, 14, tree)
        tree = Tree.insert(4, 15, tree)
        tree = Tree.insert(1, 16, tree)
        tree = Tree.insert(9, 17, tree)
        key = Tree.traverse(tree, 17)
        key
    end
end