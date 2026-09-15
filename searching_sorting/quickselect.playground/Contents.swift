// Given an unsorted array, find the kth largest element.
// **Target: O(n)** average

func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    var result = nums
    
    var lo = 0, hi = result.count - 1
    while lo < hi {
        let pivot = result[hi]
        var i = lo
        for j in lo..<hi {
            if result[j] > pivot {
                result.swapAt(i, j)
                i += 1
            }
        }
        result.swapAt(i, hi)
        
        if i == k - 1 {
            break
        }
        
        if i > k - 1 {
            hi = i - 1
        } else {
            lo = i + 1
        }
    }
   
    return result[k - 1]
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("classic case", findKthLargest([3, 2, 1, 5, 6, 4], 2), 5)
check("duplicates present", findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4), 4)
check("single element", findKthLargest([1], 1), 1)
check("k = 1, the maximum", findKthLargest([5, 3, 8, 1, 9, 2], 1), 9)
check("k = count, the minimum", findKthLargest([5, 3, 8, 1, 9, 2], 6), 1)
check("all identical values", findKthLargest([7, 7, 7, 7], 2), 7)
check("already ascending", findKthLargest([1, 2, 3, 4, 5], 3), 3)
check("already descending", findKthLargest([5, 4, 3, 2, 1], 3), 3)
check("negative numbers", findKthLargest([-1, -2, -3, -4], 2), -2)
check("duplicate max value, small k", findKthLargest([8, 3, 8, 2, 1], 2), 8)
