// Implement merge sort on an array of integers
// **Target: O(n log n)**

func mergeSort(_ nums: [Int]) -> [Int] {
    if nums.count <= 1 { return nums }
    
    let h = nums.count / 2
    
    let leftSorted = mergeSort(Array(nums[..<h]))
    let rightSorted = mergeSort(Array(nums[h...]))
    
    return mergeTwoSorted(leftSorted, rightSorted)
}

// Merge two sorted arrays into one sorted array.
// **Target: O(n + m)**
func mergeTwoSorted(_ numsA: [Int], _ numsB: [Int]) -> [Int] {
    var i = 0, j = 0
    var result: [Int] = []
    result.reserveCapacity(numsA.count + numsB.count)
    
    
    while i < numsA.count && j < numsB.count {
        if numsA[i] <= numsB[j] {
            result.append(numsA[i])
            i += 1
        } else {
            result.append(numsB[j])
            j += 1
        }
    }
    
    result += numsA[i...] + numsB[j...]
    
    return result
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("empty array", mergeSort([]), [])
check("single element", mergeSort([1]), [1])
check("small unsorted", mergeSort([3, 1, 2]), [1, 2, 3])
check("reverse sorted", mergeSort([5, 4, 3, 2, 1]), [1, 2, 3, 4, 5])
check("already sorted", mergeSort([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5])
check("all duplicates", mergeSort([2, 2, 2, 2]), [2, 2, 2, 2])
check("negative numbers mixed in", mergeSort([-3, 5, -1, 0, 2]), [-3, -1, 0, 2, 5])
check("odd count — uneven split", mergeSort([9, 1, 5, 3, 7]), [1, 3, 5, 7, 9])

check("interleaved, equal length", mergeTwoSorted([1, 3, 5], [2, 4, 6]), [1, 2, 3, 4, 5, 6])
check("first array empty", mergeTwoSorted([], [1, 2, 3]), [1, 2, 3])
check("second array empty", mergeTwoSorted([1, 2, 3], []), [1, 2, 3])
check("identical arrays", mergeTwoSorted([1, 2, 3], [1, 2, 3]), [1, 1, 2, 2, 3, 3])
check("all duplicates in both", mergeTwoSorted([1, 1, 1], [1, 1, 1]), [1, 1, 1, 1, 1, 1])
check("negative numbers", mergeTwoSorted([-5, -2, 0], [-4, -1, 3]), [-5, -4, -2, -1, 0, 3])
check("single elements each", mergeTwoSorted([1], [2]), [1, 2])
check("single elements, reversed order", mergeTwoSorted([5], [1]), [1, 5])
check("one array exhausts before the other", mergeTwoSorted([1, 2, 10], [3, 4, 5]), [1, 2, 3, 4, 5, 10])
