// Find the length of the longest substring without repeating characters.
// **Target: O(n)**

func lengthOfLongestSubstring(_ text: String) -> Int {
    let t = Array(text)
    
    var lastSeenAt: [Character: Int] = [:]
    var windowStart = 0
    var longestSubstring = 0
    
    for (i, c) in t.enumerated() {
        if let lastSeenAt = lastSeenAt[c] {
            windowStart = max(lastSeenAt + 1, windowStart)
        }
        lastSeenAt[c] = i
        longestSubstring = max(longestSubstring, i - windowStart + 1)
    }
    
    return longestSubstring
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail (expected \(expected) got \(actual))", "-", name)
}

check("classic mixed", lengthOfLongestSubstring("abcabcbb"), 3)
check("all same character", lengthOfLongestSubstring("bbbbb"), 1)
check("repeat then recover", lengthOfLongestSubstring("pwwkew"), 3)
check("empty string", lengthOfLongestSubstring(""), 0)
check("single space", lengthOfLongestSubstring(" "), 1)
check("two distinct characters", lengthOfLongestSubstring("au"), 2)
check("window-start jump-back gotcha", lengthOfLongestSubstring("dvdf"), 3)
check("classic off-by-one gotcha", lengthOfLongestSubstring("abba"), 2)
check("single character", lengthOfLongestSubstring("a"), 1)
check("all unique", lengthOfLongestSubstring("abcdef"), 6)
