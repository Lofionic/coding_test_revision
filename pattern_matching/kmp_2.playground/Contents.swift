// Given a text and a pattern, find all starting indices where the pattern occurs in the text.
// **Target: O(n + m)** (n = text length, m = pattern length)

func findIndicesOfMatches(in text: String, pattern: String) -> [Int] {
    let t = Array(text)
    let p = Array(pattern)
    
    guard !p.isEmpty else { return [] }
    
    var lps: [Int] = .init(repeating: 0, count: p.count)
    var len = 0
    var i = 1
    
    // Build LPS array
    while i < p.count {
        if p[len] == p[i] {
            len += 1
            lps[i] = len
            i += 1
        } else if len > 0 {
            len = lps[len - 1]
        } else {
            len = 0
            i += 1
        }
    }
    
    // Search
    var k = 0, j = 0
    var matches: [Int] = []
    
    while k < t.count {
        if t[k] == p[j] {
            k += 1
            j += 1
            if j == p.count {
                matches.append(k - j)
                j = lps[j - 1]
            }
        } else if j > 0 {
            j = lps[j - 1]
        } else {
            k += 1
        }
    }
    
    return matches
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("basic single match",
      findIndicesOfMatches(in: "hello world", pattern: "world"), [6])

check("multiple non-overlapping matches",
      findIndicesOfMatches(in: "abcabcabc", pattern: "abc"), [0, 3, 6])

check("overlapping matches (aa in aaaa)",
      findIndicesOfMatches(in: "aaaa", pattern: "aa"), [0, 1, 2])

check("overlapping matches (aaa in aaaaa)",
      findIndicesOfMatches(in: "aaaaa", pattern: "aaa"), [0, 1, 2])

check("overlapping matches (abab in abababab)",
      findIndicesOfMatches(in: "abababab", pattern: "abab"), [0, 2, 4])

check("no match",
      findIndicesOfMatches(in: "hello", pattern: "xyz"), [])

check("match touching start and end",
      findIndicesOfMatches(in: "abcabc", pattern: "abc"), [0, 3])

check("pattern == text",
      findIndicesOfMatches(in: "abc", pattern: "abc"), [0])

check("pattern longer than text",
      findIndicesOfMatches(in: "ab", pattern: "abc"), [])

check("single-char exact match",
      findIndicesOfMatches(in: "a", pattern: "a"), [0])

check("empty text",
      findIndicesOfMatches(in: "", pattern: "a"), [])

check("empty pattern",
      findIndicesOfMatches(in: "hello world", pattern: ""), [])

