// Given a set of coin denominations and a target amount, find the minimum number of coins needed to make that amount.
// **Target: O(amount × number of coin types)**

func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    guard amount > 0 else { return 0 }
    guard coins.count > 0 else { return -1 }
    
    func coinChangeRecursive(_ coins: [Int], _ amount: Int, _ m: inout [Int: Int]) -> Int {
        if let m = m[amount] { return m }
        
        var r = -1
        for c in coins where c > 0 {
            if c == amount {
                m[amount] = 1
                return 1
            }
            
            if c < amount {
                let solve = coinChangeRecursive(coins, amount - c, &m) + 1
                if solve == 0 { continue }
                if r == -1 || r > solve { r = solve }
            }
        }
        
        m[amount] = r
        
        return r
    }
    
    var memo: [Int: Int] = [:]
    return coinChangeRecursive(coins, amount, &memo)
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print("\(name): \(actual == expected ? "pass" : "fail") (got \(actual), expected \(expected))")
}

check("classic", coinChange([2, 5], 6), 3)
check("classic", coinChange([1,2,5], 11), 3)
check("impossible", coinChange([2], 3), -1)
check("zero amount", coinChange([1,2,5], 0), 0)
check("empty coins, positive amount", coinChange([], 5), -1)
check("empty coins, zero amount", coinChange([], 0), 0)
check("single coin exact", coinChange([7], 7), 1)
check("single coin no match", coinChange([7], 15), -1)
check("needs many of same coin", coinChange([1], 11), 11)
check("duplicate denominations", coinChange([1,1,2,5], 11), 3)
check("zero-value coin doesn't help or break anything", coinChange([0,1,3,4], 6), 2)
check("classic large case", coinChange([186,419,83,408], 6249), 20)

//// performance sanity check -- catches a solution that's technically correct
//// but still exponential (naive recursion without memo/DP table)
import Foundation

let start = Date()
let big = coinChange([1,5,10,25], 9999)
let elapsed = Date().timeIntervalSince(start)
check("large amount value", big, 405)
check("large amount completes in under 1s (took \(elapsed)s)", elapsed < 1.0, true)
