// Given a graph and two nodes, determine if there's a path between them.
// **Target: O(V + E)**

func hasPath(graph: [Int: [Int]], start: Int, end: Int) -> Bool {
    var visited: Set<Int> = []
    
    if start == end { return true }
    
    visited.insert(start)
    
    var edges = graph[start, default: []]
    visited.formUnion(Set(edges))
    
    while let edge = edges.popLast() {
        if edge == end { return true }
        for e in graph[edge, default: []] where !visited.contains(e) {
            visited.insert(e)
            edges.append(e)
        }
    }
    
    return false
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("direct chain path exists",
      hasPath(graph: [1: [2], 2: [3], 3: [4]], start: 1, end: 4), true)

check("target unreachable",
      hasPath(graph: [1: [2], 2: [3], 3: [4]], start: 1, end: 5), false)

check("start equals end — trivially true",
      hasPath(graph: [1: [2], 2: [3]], start: 1, end: 1), true)

check("multiple paths converge to target",
      hasPath(graph: [1: [2, 3], 2: [4], 3: [4], 4: [5]], start: 1, end: 5), true)

check("cycle doesn't cause infinite loop, path exists",
      hasPath(graph: [1: [2], 2: [1], 3: [4]], start: 1, end: 2), true)

check("cycle doesn't cause infinite loop, no path to unrelated node",
      hasPath(graph: [1: [2], 2: [1]], start: 1, end: 3), false)

check("leaf node — no outgoing edges",
      hasPath(graph: [1: []], start: 1, end: 2), false)

check("two disconnected components",
      hasPath(graph: [1: [2], 3: [4]], start: 1, end: 4), false)

check("self-loop doesn't create a false path elsewhere",
      hasPath(graph: [1: [1], 2: [3]], start: 1, end: 3), false)

check("directed edge — wrong direction fails",
      hasPath(graph: [1: [2], 2: [3]], start: 3, end: 1), false)
