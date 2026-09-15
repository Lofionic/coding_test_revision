// Design a data structure that supports adding numbers one at a time and finding the median at any point.
// **Target: O(log n)** per insertion, O(1) per median query

protocol Heap {
    associatedtype E: Comparable
    
    var heap: [E] { get set }
    var isEmpty: Bool { get }
    var count: Int { get }
    
    func peek() -> E?
    mutating func insert(_ val: E)
    mutating func extract() -> E?
    
    mutating func siftUp(_ i: Int)
    mutating func siftDown(_ i: Int)
}

extension Heap where E == Int {
    var isEmpty: Bool { heap.isEmpty }
    var count: Int { heap.count }
    
    func peek() -> E? {
        return heap.first
    }
    
    mutating func insert(_ val: E) {
        heap.append(val)
        if heap.count > 1 {
            siftUp(heap.count - 1)
        }
    }
    
    mutating func extract() -> E? {
        guard !heap.isEmpty else { return nil }
        heap.swapAt(0, heap.count - 1)
        let r = heap.remove(at: heap.count - 1)
        siftDown(0)
        return r
    }
}

struct MinHeap: Heap {
    typealias E = Int
    
    var heap: [Int] = []

    mutating func siftUp(_ i: Int) {
        func parent(_ i: Int) -> Int {
            return (i - 1) / 2
        }
        
        var i = i
        while i > 0 && heap[i] < heap[parent(i)] {
            heap.swapAt(i, parent(i))
            i = parent(i)
        }
    }
    
    mutating func siftDown(_ i: Int) {
        var smallest = i
        let left = (i * 2) + 1
        let right = (i * 2) + 2
        
        if left < heap.count && heap[left] < heap[smallest] {
            smallest = left
        }
        if right < heap.count && heap[right] < heap[smallest] {
            smallest = right
        }
        if smallest != i {
            heap.swapAt(smallest, i)
            siftDown(smallest)
        }
    }
}

struct MaxHeap: Heap {
    var heap: [Int] = []
    
    mutating func siftUp(_ i: Int) {
        func parent(_ i: Int) -> Int {
            return (i - 1) / 2
        }
        
        var i = i
        while i > 0 && heap[i] > heap[parent(i)] {
            heap.swapAt(i, parent(i))
            i = parent(i)
        }
    }
    
    mutating func siftDown(_ i: Int) {
        var largest = i
        let left = (i * 2) + 1
        let right = (i * 2) + 2
        
        if left < heap.count && heap[left] > heap[largest] {
            largest = left
        }
        if right < heap.count && heap[right] > heap[largest] {
            largest = right
        }
        if largest != i {
            heap.swapAt(largest, i)
            siftDown(largest)
        }
    }
}

struct MedianFinder {
    var minHeap = MinHeap()
    var maxHeap = MaxHeap()
    
    mutating func addNum(_ num: Int) {
        if minHeap.isEmpty && maxHeap.isEmpty {
            maxHeap.insert(num)
        } else if num <= maxHeap.peek() ?? .max {
            maxHeap.insert(num)
        } else {
            minHeap.insert(num)
        }
        
        while minHeap.count > maxHeap.count + 1 {
            let g = minHeap.extract()!
            maxHeap.insert(g)
        }
        
        while maxHeap.count > minHeap.count + 1 {
            let g = maxHeap.extract()!
            minHeap.insert(g)
        }
    }
    
    func findMedian() -> Double {
        if maxHeap.count > 0 && maxHeap.count == minHeap.count {
            return Double(maxHeap.peek()! + minHeap.peek()!) / 2.0
        } else if maxHeap.count > 0 && maxHeap.count > minHeap.count {
            return Double(maxHeap.peek()!)
        } else if minHeap.count > 0 && minHeap.count > maxHeap.count {
            return Double(minHeap.peek()!)
        }
        return -1
    }
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print("\(name): \(actual == expected ? "pass" : "fail") (got \(actual), expected \(expected))")
}

var mf1 = MedianFinder()
mf1.addNum(5); check("after [5]", mf1.findMedian(), 5.0)
mf1.addNum(15); check("after [5,15]", mf1.findMedian(), 10.0)
mf1.addNum(1); check("after [5,15,1]", mf1.findMedian(), 5.0)
mf1.addNum(3); check("after [5,15,1,3]", mf1.findMedian(), 4.0)

var mf2 = MedianFinder()
mf2.addNum(1); check("after [1]", mf2.findMedian(), 1.0)
mf2.addNum(2); check("after [1,2]", mf2.findMedian(), 1.5)
mf2.addNum(3); check("after [1,2,3]", mf2.findMedian(), 2.0)

var mf3 = MedianFinder()
let negatives = [-1,-2,-3,-4,-5]
let negExpected = [-1.0,-1.5,-2.0,-2.5,-3.0]
for (i, n) in negatives.enumerated() {
    mf3.addNum(n)
    check("negatives step \(i+1)", mf3.findMedian(), negExpected[i])
}

var mf4 = MedianFinder()
for _ in 0..<4 { mf4.addNum(2); check("duplicates running", mf4.findMedian(), 2.0) }

var mf5 = MedianFinder()
let mixed = [41,35,62,5,97,108]
let mixedExpected = [41.0,38.0,41.0,38.0,41.0,51.5]
for (i, n) in mixed.enumerated() {
    mf5.addNum(n)
    check("mixed step \(i+1)", mf5.findMedian(), mixedExpected[i])
}
