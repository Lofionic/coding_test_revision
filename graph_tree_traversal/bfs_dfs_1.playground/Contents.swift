// Given a grid of 1s (land) and 0s (water), count the number of islands.
// **Target: O(rows × cols)**

func numIslands(_ grid: [[Character]]) -> Int {
    var g = grid
        
    func neighbours(_  x: Int, _ y: Int) -> [(Int, Int)] {
        var result: [(Int, Int)] = []
        if y > 0 { result.append((x, y - 1)) }
        if y < g.count - 1 && g[y + 1].count > x { result.append((x, y + 1)) }
        if x > 0 { result.append((x - 1, y)) }
        if x < g[y].count - 1 { result.append((x + 1, y)) }
        return result
    }
    
    func flood(_ x: Int, _ y: Int) {
        var queue: [(Int, Int)] = [(x, y)]
        g[y][x] = "0"
        
        
        while let q = queue.popLast() {
            for n in neighbours(q.0, q.1) where g[n.1][n.0] == "1" {
                g[n.1][n.0] = "0"
                queue.append(n)
            }
        }
    }
    
    var islands = 0
    
    for row in 0..<g.count {
        for col in 0..<g[row].count {
            if g[row][col] == "1" {
                flood(col, row)
                islands += 1
            }
        }
    }
    
    return islands
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("classic multi-island grid",
      numIslands([
        Array("11000"),
        Array("11000"),
        Array("00100"),
        Array("00011"),
      ]), 3)

check("multiple separated single cells",
      numIslands([
        Array("10101"),
        Array("00000"),
        Array("10101"),
      ]), 6)

check("all water",
      numIslands([
        Array("000"),
        Array("000"),
      ]), 0)

check("all land, one big island",
      numIslands([
        Array("111"),
        Array("111"),
      ]), 1)

check("diagonal cells are NOT connected",
      numIslands([
        Array("10"),
        Array("01"),
      ]), 2)

check("single land cell",
      numIslands([Array("1")]), 1)

check("single water cell",
      numIslands([Array("0")]), 0)

check("empty grid",
      numIslands([]), 0)

check("L-shaped island counts as one",
      numIslands([
        Array("100"),
        Array("100"),
        Array("111"),
      ]), 1)
