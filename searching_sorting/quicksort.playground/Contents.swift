// Implement quicksort on an array of integers
// **Target: O(n log n)** average (O(n²) worst case, worth naming)

func quicksort(_ nums: [Int]) -> [Int] {
    var result = nums
    
    func sort(_ lo: Int, _ hi: Int) {
        guard lo < hi else { return }
        let pivot = result[hi]
        var i = lo
        
        for j in lo..<hi {
            if result[j] < pivot {
                result.swapAt(i, j)
                i += 1
            }
        }
        result.swapAt(i, hi) // Swap pivot in between lowers and highers
        sort(0, i - 1) // i is pivot number
        sort(i + 1, hi)
    }
    
    sort(0, result.count - 1)
    return result
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("empty array", quicksort([]), [])
check("single element", quicksort([1]), [1])
check("small unsorted", quicksort([3, 1, 2]), [1, 2, 3])
check("reverse sorted — worst-case pivot pattern", quicksort([5, 4, 3, 2, 1]), [1, 2, 3, 4, 5])
check("already sorted — also a worst-case pivot pattern", quicksort([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5])
check("all duplicates", quicksort([2, 2, 2, 2]), [2, 2, 2, 2])
check("negative numbers mixed in", quicksort([-3, 5, -1, 0, 2]), [-3, -1, 0, 2, 5])
check("repeated values, not all identical", quicksort([1, 1, 2, 2, 3, 3]), [1, 1, 2, 2, 3, 3])
