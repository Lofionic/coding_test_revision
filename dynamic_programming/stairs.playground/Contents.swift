// You can climb 1 or 2 steps at a time. How many distinct ways are there to climb to the top of a staircase of n steps?
// **Target: O(n)**

func climbStairs(_ n: Int) -> Int {
    var m: [Int: Int] = [:]
    
    func _climbStairs(_ n: Int, _ m: inout [Int: Int]) -> Int {
        if let memo = m[n] {
            return memo
        }
        
        if n <= 2 {
            m[n] = n
            return n
        }
        
        let r = _climbStairs(n - 1, &m) + _climbStairs(n - 2, &m)
        m[n] = r
        return r
    }
    
    return _climbStairs(n, &m)
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print("\(name): \(actual == expected ? "pass" : "fail") (got \(actual), expected \(expected))")
}

check("climbStairs(1)", climbStairs(1), 1)
check("climbStairs(2)", climbStairs(2), 2)
check("climbStairs(3)", climbStairs(3), 3)
check("climbStairs(4)", climbStairs(4), 5)
check("climbStairs(5)", climbStairs(5), 8)
check("climbStairs(6)", climbStairs(6), 13)
check("climbStairs(7)", climbStairs(7), 21)
check("climbStairs(8)", climbStairs(8), 34)
check("climbStairs(9)", climbStairs(9), 55)
check("climbStairs(10)", climbStairs(10), 89)
check("climbStairs(15)", climbStairs(15), 987)
check("climbStairs(20)", climbStairs(20), 10946)
check("climbStairs(30)", climbStairs(30), 1346269)

// performance sanity check -- catches a solution that's secretly still O(2^n)
// (e.g. naive double-recursion with no memo/iteration) despite passing the small cases above
import Foundation

let start = Date()
let big = climbStairs(35)
let elapsed = Date().timeIntervalSince(start)
check("climbStairs(35) value", big, 14930352)
check("climbStairs(35) completes in under 1s (took \(elapsed)s)", elapsed < 1.0, true)
