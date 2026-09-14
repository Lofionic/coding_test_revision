// Given an array of positive integers and a target sum, find the length of the smallest contiguous subarray whose sum is ≥ target
// **Target: O(n)**

func minSubArrayLen(target: Int, _ nums: [Int]) -> Int {
    var windowStart = 0
    var rollingTotal = 0
    var result = 0
    
    for (index, num) in nums.enumerated() {
        rollingTotal += num
        while rollingTotal >= target {
            if result == 0 {
                result = index - windowStart + 1
            } else {
                result = min(result, index - windowStart + 1)
            }
            rollingTotal -= nums[windowStart]
            windowStart += 1
        }
    }
    
    return result
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail (expected \(expected) got \(actual))", "-", name)
}

check("classic case", minSubArrayLen(target: 7, [2, 3, 1, 2, 4, 3]), 2)
check("single element already meets target", minSubArrayLen(target: 4, [1, 4, 4]), 1)
check("no subarray reaches target — total too small", minSubArrayLen(target: 11, [1, 1, 1, 1, 1, 1, 1, 1]), 0)
check("whole array needed", minSubArrayLen(target: 15, [1, 2, 3, 4, 5]), 5)
check("single-element array, meets target exactly", minSubArrayLen(target: 5, [5]), 1)
check("impossible target", minSubArrayLen(target: 100, [1, 2, 3, 4, 5]), 0)
check("shrink-while-valid gotcha", minSubArrayLen(target: 7, [2, 1, 5, 2, 3, 2]), 2)
check("empty array", minSubArrayLen(target: 1, []), 0)
check("small window at the very end, sum happens to equal windowStart", minSubArrayLen(target: 5, [1, 1, 1, 1, 1, 5]), 1)
