// Write a brute-force recursive Fibonacci function, then optimize it with memoization.
// **Target: O(n)** memoized (brute force is O(2ⁿ) — know both, and know why)

func fibBruteForce(_ n: Int) -> Int {
    if n <= 1 {
        return n
    }
    
    return fibBruteForce(n - 2) + fibBruteForce(n - 1)
}

func fibMemoized(_ n: Int, _ m: inout [Int: Int]) -> Int {
    if let memo = m[n] {
        return memo
    }
    
    if n <= 1 {
        m[n] = n
        return n
    }
    
    let t = fibMemoized(n - 2, &m) + fibMemoized(n - 1, &m)
    m[n] = t
    
    return t
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print("\(name): \(actual == expected ? "pass" : "fail") (got \(actual), expected \(expected))")
}

// --- brute force correctness ---
check("fibBruteForce(0)", fibBruteForce(0), 0)
check("fibBruteForce(1)", fibBruteForce(1), 1)
check("fibBruteForce(2)", fibBruteForce(2), 1)
check("fibBruteForce(3)", fibBruteForce(3), 2)
check("fibBruteForce(4)", fibBruteForce(4), 3)
check("fibBruteForce(5)", fibBruteForce(5), 5)
check("fibBruteForce(6)", fibBruteForce(6), 8)
check("fibBruteForce(10)", fibBruteForce(10), 55)
check("fibBruteForce(15)", fibBruteForce(15), 610)
check("fibBruteForce(20)", fibBruteForce(20), 6765)   // don't push this much higher -- it's O(2^n)

// --- memoized correctness ---
var m0: [Int: Int] = [:]
check("fibMemoized(0)", fibMemoized(0, &m0), 0)

var m1: [Int: Int] = [:]
check("fibMemoized(1)", fibMemoized(1, &m1), 1)

var m2: [Int: Int] = [:]
check("fibMemoized(10)", fibMemoized(10, &m2), 55)

var m3: [Int: Int] = [:]
check("fibMemoized(20)", fibMemoized(20, &m3), 6765)

var m4: [Int: Int] = [:]
check("fibMemoized(40)", fibMemoized(40, &m4), 102334155)   // brute force would choke here; memoized shouldn't

var m5: [Int: Int] = [:]
check("fibMemoized(50)", fibMemoized(50, &m5), 12586269025)

// reusing the same memo across separate calls should still be correct
var shared: [Int: Int] = [:]
check("fibMemoized(5) via shared memo", fibMemoized(5, &shared), 5)
check("fibMemoized(8) via same shared memo", fibMemoized(8, &shared), 21)
check("fibMemoized(3) via same shared memo (already cached)", fibMemoized(3, &shared), 2)

// brute force and memoized should agree everywhere they overlap
for n in 0...20 {
    var m: [Int: Int] = [:]
    check("fibBruteForce(\(n)) == fibMemoized(\(n))", fibBruteForce(n), fibMemoized(n, &m))
}

// --- the actual point of memoizing: this should be fast, not just correct ---
import Foundation

let start = Date()
var perfMemo: [Int: Int] = [:]
let result = fibMemoized(35, &perfMemo)
let elapsed = Date().timeIntervalSince(start)
check("fibMemoized(35) value", result, 9227465)
check("fibMemoized(35) completes in under 1s (took \(elapsed)s)", elapsed < 1.0, true)
