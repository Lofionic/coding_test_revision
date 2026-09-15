// Given item weights, values, and a weight capacity, find the maximum total value you can carry without exceeding the capacity.
// **Target: O(n × capacity)**

func knapsack(weights: [Int], values: [Int], capacity: Int) -> Int {
    var memo: [[Int]] = [[]]
    
    func _knapsack(weights: [Int], values: [Int], capacity: Int, n: Int) -> Int {
        if n == 0 { return 0 }
        
        if memo[capacity][n] > -1 {
           return memo[capacity][n]
        }
        
        var pick = 0
        
        // Pick nth item if it does not exceed the capacity of knapsack
        if weights[n - 1] <= capacity {
            pick = values[n - 1] + _knapsack(
                weights: weights,
                values: values,
                capacity: capacity - weights[n - 1],
                n: n - 1
            )
        }
        
        // Don't pick the nth item
        let noPick = _knapsack(weights: weights, values: values, capacity: capacity, n: n - 1)

        // Return max
        let result = max(pick, noPick)
        memo[capacity][n] = result
        
        return result
    }
    
    return _knapsack(weights: weights, values: values, capacity: capacity, n: weights.count)
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print("\(name): \(actual == expected ? "pass" : "fail") (got \(actual), expected \(expected))")
}

check("classic", knapsack(weights: [1,3,4,5], values: [1,4,5,7], capacity: 7), 9)
check("no items", knapsack(weights: [], values: [], capacity: 10), 0)
check("zero capacity", knapsack(weights: [1,2,3], values: [10,20,30], capacity: 0), 0)
check("single item fits exactly", knapsack(weights: [5], values: [42], capacity: 5), 42)
check("single item too heavy", knapsack(weights: [10], values: [100], capacity: 5), 0)
check("all items too heavy", knapsack(weights: [10,20,30], values: [1,2,3], capacity: 5), 0)
check("capacity generous, take everything", knapsack(weights: [1,2,3], values: [10,20,30], capacity: 100), 60)
check("same weight, pick higher value", knapsack(weights: [4,4], values: [10,50], capacity: 4), 50)
check("zero-weight item is free, always worth taking", knapsack(weights: [0,3], values: [5,4], capacity: 3), 9)
check("two zero-weight items", knapsack(weights: [0,0,2], values: [3,4,10], capacity: 2), 17)
check("duplicate items treated independently", knapsack(weights: [2,2,2], values: [3,3,3], capacity: 4), 6)
check("classic 2", knapsack(weights: [2,3,4,5], values: [3,4,5,6], capacity: 5), 7)
check("larger mixed", knapsack(weights: [2,3,4,5,9], values: [3,4,5,8,10], capacity: 20), 26)
