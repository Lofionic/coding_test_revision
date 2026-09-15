// Implement in-order traversal of a binary tree.
// **Target: O(n)**

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

func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var result: [Int] = []
    
    func processInorder(_ node: TreeNode?, _ r: inout [Int]) {
        guard let node else { return }
        processInorder(node.left, &r)
        r.append(node.val)
        processInorder(node.right, &r)
    }
    
    processInorder(root, &result)
    
    return result
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("empty tree", inorderTraversal(nil), [])
check("single node", inorderTraversal(TreeNode(5)), [5])

// left-skewed chain: 3 <- 2 <- 1
check("left-skewed chain",
      inorderTraversal(TreeNode(3, TreeNode(2, TreeNode(1)))), [1, 2, 3])

// right-skewed chain: 1 -> 2 -> 3
check("right-skewed chain",
      inorderTraversal(TreeNode(1, nil, TreeNode(2, nil, TreeNode(3)))), [1, 2, 3])

// balanced BST:      4
//                 2       6
//               1   3   5   7
check("balanced BST — comes out fully sorted",
      inorderTraversal(TreeNode(4,
          TreeNode(2, TreeNode(1), TreeNode(3)),
          TreeNode(6, TreeNode(5), TreeNode(7))
      )), [1, 2, 3, 4, 5, 6, 7])

// non-BST tree — values NOT in sorted order, just checking left-self-right mechanics
//      10
//     /   \
//   20    30
//   /
//  5
check("non-BST tree — output need not be sorted",
      inorderTraversal(TreeNode(10,
          TreeNode(20, TreeNode(5)),
          TreeNode(30)
      )), [5, 20, 10, 30])

// asymmetric — root has only a right child; that subtree is itself unbalanced
//   1
//    \
//     4
//    / \
//   2   5
//    \
//     3
check("asymmetric shape",
      inorderTraversal(TreeNode(1, nil,
          TreeNode(4, TreeNode(2, nil, TreeNode(3)), TreeNode(5))
      )), [1, 2, 3, 4, 5])
