// Given a sorted array, find the index of a target value (or -1 if not present)
// **Target: O(log n)**

func binarySearch(_ nums: [Int], target: Int) -> Int {
    var low = 0
    var high = nums.count - 1
    
    while low <= high {
        let mid = low + (high - low) / 2
        if nums[mid] == target {
            return mid
        }
        
        if nums[mid] > target {
            high = mid - 1
        } else {
            low = mid + 1
        }
    }
    
    return -1
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("target in the middle", binarySearch([1, 3, 5, 7, 9, 11], target: 7), 3)
check("target at the start", binarySearch([1, 3, 5, 7, 9, 11], target: 1), 0)
check("target at the end", binarySearch([1, 3, 5, 7, 9, 11], target: 11), 5)
check("target absent, falls between elements", binarySearch([1, 3, 5, 7, 9, 11], target: 4), -1)
check("empty array", binarySearch([], target: 5), -1)
check("single element, present", binarySearch([5], target: 5), 0)
check("single element, absent", binarySearch([5], target: 3), -1)
check("two elements, target at index 1", binarySearch([2, 8], target: 8), 1)
check("target smaller than all elements", binarySearch([10, 20, 30], target: 1), -1)
check("target larger than all elements", binarySearch([10, 20, 30], target: 100), -1)
