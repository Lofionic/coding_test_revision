// Given a sorted array of integers, find two numbers that sum to a target value.
// **Target: O(n)**

func twoSumSorted(_ nums: [Int], target: Int) -> (Int, Int)? {
    var i = 0
    var j = nums.count - 1
    
    while i < j {
        let f = nums[i] + nums[j]
        if f == target {
            return (i, j)
        } else if f < target {
            i += 1
        } else if f > target {
            j -= 1
        }
    }
    
    
    return nil
}

func checkTuple(_ name: String, _ actual: (Int, Int)?, _ expected: (Int, Int)?) {
    let pass: Bool
    switch (actual, expected) {
    case (nil, nil): pass = true
    case let (a?, e?): pass = a == e
    default: pass = false
    }
    print(pass ? "pass" : "fail", "-", name)
}


checkTuple("basic case",
           twoSumSorted([1, 2, 3, 4, 6], target: 6), (1, 3))

checkTuple("no valid pair",
           twoSumSorted([1, 2, 3], target: 100), nil)

checkTuple("negative numbers",
           twoSumSorted([-3, -1, 0, 2, 4, 6], target: 1), (0, 4))

checkTuple("exactly two elements",
           twoSumSorted([2, 4], target: 6), (0, 1))

checkTuple("duplicate values at distinct indices",
           twoSumSorted([3, 3], target: 6), (0, 1))

checkTuple("duplicates skipped before match found",
           twoSumSorted([1, 2, 3, 4, 4, 9], target: 8), (3, 4))

// exposes the same-index-reuse bug — pointers meet at the array's last index
checkTuple("no pair — only a self-pairing at array end sums to target",
           twoSumSorted([1, 2, 3], target: 6), nil)

// same bug, but the meeting point isn't at either end
checkTuple("no pair — only a self-pairing mid-array sums to target",
           twoSumSorted([1, 3, 10, 20], target: 6), nil)

checkTuple("empty array",
           twoSumSorted([], target: 5), nil)

checkTuple("single element — no valid pair possible",
           twoSumSorted([7], target: 14), nil)
