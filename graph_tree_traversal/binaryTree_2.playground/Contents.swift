// Given a binary search tree, find the lowest common ancestor of two given nodes.
// **Target: O(h)**, h = tree height (O(log n) balanced, O(n) worst case)

final class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

func lowestCommonAncestor(_ root: TreeNode?, _ p: Int, _ q: Int) -> TreeNode? {
    func lca_depthFirst(_ node: TreeNode?) -> TreeNode? {
        guard let node else { return nil }
        
        if node.val == p || node.val == q {
            return node
        }
        
        let left = lca_depthFirst(node.left)
        let right = lca_depthFirst(node.right)
        
        if left != nil && right != nil { return node }
        if left != nil { return left } else { return right }
    }
    
    func lca_binarySearch(_ node: TreeNode?) -> TreeNode? {
        guard let node else { return nil }
        
        if p < node.val && q < node.val {
            return lca_binarySearch(node.left)
        } else if p > node.val && q > node.val {
            return lca_binarySearch(node.right)
        } else {
            return node
        }
    }
    
    return lca_depthFirst(root)
}

let tree = TreeNode(6,
    TreeNode(2, TreeNode(0), TreeNode(4, TreeNode(3), TreeNode(5))),
    TreeNode(8, TreeNode(7), TreeNode(9))
)


func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}


check("p and q in different subtrees — LCA is the root",
      lowestCommonAncestor(tree, 2, 8)?.val, 6)

check("q is a descendant of p — LCA is p itself",
      lowestCommonAncestor(tree, 2, 4)?.val, 2)

check("both deep in the same subtree, diverging partway up",
      lowestCommonAncestor(tree, 0, 5)?.val, 2)

check("both under a different internal node",
      lowestCommonAncestor(tree, 3, 5)?.val, 4)

check("both leaves under the right subtree",
      lowestCommonAncestor(tree, 7, 9)?.val, 8)

check("p equals q — the node is its own ancestor",
      lowestCommonAncestor(tree, 4, 4)?.val, 4)

check("order of p and q reversed — should be symmetric",
      lowestCommonAncestor(tree, 9, 8)?.val, 8)

check("single node tree, p and q both the root",
      lowestCommonAncestor(TreeNode(5), 5, 5)?.val, 5)
