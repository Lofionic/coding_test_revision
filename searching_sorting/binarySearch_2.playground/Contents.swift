// Given a sorted array of 0s followed by 1s, find the index of the first 1.
// **Target: O(log n)**

func firstOne(_ arr: [Int]) -> Int {
    var lo = 0
    var hi = arr.count - 1
    
    var result = -1
    
    while lo <= hi {
        let mid = lo + (hi - lo) / 2
        
        if arr[mid] == 1 {
            result = mid
            hi = mid - 1
        } else {
            lo = mid + 1
        }
    }
    
    return result
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("boundary in the middle", firstOne([0, 0, 0, 1, 1, 1]), 3)
check("no 1s at all", firstOne([0, 0, 0, 0, 0]), -1)
check("all 1s — boundary at index 0", firstOne([1, 1, 1, 1]), 0)
check("boundary at the very end", firstOne([0, 0, 0, 0, 1]), 4)
check("single 0 only", firstOne([0, 1]), 1)
check("single element, a 1", firstOne([1]), 0)
check("single element, a 0", firstOne([0]), -1)
check("empty array", firstOne([]), -1)
check("boundary right after the first element", firstOne([0, 1, 1, 1, 1]), 1)
check("lost candidate, minimal case", firstOne([0, 1, 1]), 1)
check("lost candidate causes false negative", firstOne([0, 0, 0, 1, 1, 1, 1]), 3)
