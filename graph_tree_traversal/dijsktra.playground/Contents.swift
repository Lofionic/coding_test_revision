// Given a weighted graph and a start node, find the shortest distance to every other node.
// **Target: O((V + E) log V)** with a priority queue

struct MinHeap<E: Comparable> {
    private var elements: [E] = []

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }

    func peek() -> E? {
        elements.first
    }

    mutating func insert(_ val: E) {
        elements.append(val)
        siftUp(from: elements.count - 1)
    }

    mutating func extractMin() -> E? {
        guard !elements.isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let min = elements.removeLast()
        if !elements.isEmpty {
            siftDown(from: 0)
        }
        return min
    }

    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && elements[child] < elements[parent] {
            elements.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1
            let right = 2 * parent + 2
            var smallest = parent

            if left < elements.count && elements[left] < elements[smallest] {
                smallest = left
            }
            if right < elements.count && elements[right] < elements[smallest] {
                smallest = right
            }
            if smallest == parent { break }

            elements.swapAt(parent, smallest)
            parent = smallest
        }
    }
}

func dijkstra(graph: [Int: [(node: Int, weight: Int)]], start: Int, nodeCount: Int) -> [Int] {
    struct Element: Comparable {
        static func < (lhs: Element, rhs: Element) -> Bool {
            lhs.d < rhs.d
        }
        
        let node: Int
        let d: Int
    }
    
    var heap = MinHeap<Element>()
    heap.insert(.init(node: start, d: 0))
    
    var shortestDistance: [Int] = .init(repeating: .max, count: nodeCount)
    shortestDistance[start] = 0
    
    var visited: Set<Int> = []
    
    while let q = heap.extractMin() {
        visited.insert(q.node)
        let edges = graph[q.node, default: []]
        for edge in edges where !visited.contains(edge.node) {
            let p = q.d + edge.weight
            if p < shortestDistance[edge.node] {
                shortestDistance[edge.node] = p
                heap.insert(.init(node: edge.node, d: p))
            }
        }
    }
    
    return shortestDistance
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("linear chain",
      dijkstra(graph: [0: [(node: 1, weight: 1)], 1: [(node: 2, weight: 2)], 2: [(node: 3, weight: 3)]],
               start: 0, nodeCount: 4),
      [0, 1, 3, 6])

check("shorter path exists via a detour, direct edge is not the shortest",
      dijkstra(graph: [0: [(node: 1, weight: 10), (node: 2, weight: 3)],
                        2: [(node: 1, weight: 2), (node: 3, weight: 8)],
                        1: [(node: 3, weight: 1)]],
               start: 0, nodeCount: 4),
      [0, 5, 3, 6])

check("unreachable nodes report Int.max",
      dijkstra(graph: [0: [(node: 1, weight: 5)], 2: [(node: 3, weight: 1)]],
               start: 0, nodeCount: 4),
      [0, 5, Int.max, Int.max])

check("single node, no edges",
      dijkstra(graph: [:], start: 0, nodeCount: 1),
      [0])

check("cycle in the graph doesn't cause infinite loop",
      dijkstra(graph: [0: [(node: 1, weight: 1)],
                        1: [(node: 2, weight: 1)],
                        2: [(node: 0, weight: 1), (node: 3, weight: 5)]],
               start: 0, nodeCount: 4),
      [0, 1, 2, 7])

check("start node's own distance is zero",
      dijkstra(graph: [0: [(node: 1, weight: 7)]], start: 0, nodeCount: 2),
      [0, 7])

check("duplicate edges between the same pair, takes the minimum",
      dijkstra(graph: [0: [(node: 1, weight: 10), (node: 1, weight: 3)]], start: 0, nodeCount: 2),
      [0, 3])

check("zero-weight edge",
      dijkstra(graph: [0: [(node: 1, weight: 0)], 1: [(node: 2, weight: 5)]], start: 0, nodeCount: 3),
      [0, 0, 5])
