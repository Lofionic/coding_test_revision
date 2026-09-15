// Given two strings, find the length of their longest common subsequence.
// **Target: O(n × m)**

func longestCommonSubsequence(_ a: String, _ b: String) -> Int {
    if a.isEmpty || b.isEmpty { return 0 }
    
    let x = Array(a)
    let y = Array(b)
    
    var dp: [[Int]] = .init(repeating: .init(repeating: 0, count: y.count + 1), count: x.count + 1)
    for i in 1...x.count {
        for j in 1...y.count {
            if x[i - 1] == y[j - 1] {
                dp[i][j] = dp[i - 1][j - 1] + 1
            } else {
                let f = dp[i - 1][j]
                let g = dp[i][j - 1]
                dp[i][j] = max(f, g)
            }
        }
    }
    
    return dp[x.count][y.count]
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print("\(name): \(actual == expected ? "pass" : "fail") (got \(actual), expected \(expected))")
}

check("classic", longestCommonSubsequence("abcde", "ace"), 3)
check("identical strings", longestCommonSubsequence("abc", "abc"), 3)
check("no common characters", longestCommonSubsequence("abc", "def"), 0)
check("one empty string", longestCommonSubsequence("", "abc"), 0)
check("both empty", longestCommonSubsequence("", ""), 0)
check("single char match", longestCommonSubsequence("a", "a"), 1)
check("single char no match", longestCommonSubsequence("a", "b"), 0)
check("classic textbook case", longestCommonSubsequence("AGGTAB", "GXTXAYB"), 4)
check("repeated characters", longestCommonSubsequence("aaaa", "aa"), 2)
check("non-contiguous subsequence", longestCommonSubsequence("abcdgh", "aedfhr"), 3)
check("case sensitivity", longestCommonSubsequence("ABC", "abc"), 0)
check("order swapped, same answer", longestCommonSubsequence("ace", "abcde"), 3)

// performance sanity check -- catches an unmemoized recursive solution
// that's technically correct but exponential
import Foundation
let start = Date()
let a = String(repeating: "abcdefghij", count: 50)   // length 500
let b = String(repeating: "jihgfedcba", count: 50)   // length 500
let big = longestCommonSubsequence(a, b)
let elapsed = Date().timeIntervalSince(start)
check("large input completes in under 1s (took \(elapsed)s)", elapsed < 1.0, true)
