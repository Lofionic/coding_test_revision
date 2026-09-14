// Given a string, find the length of the longest proper prefix that is also a suffix (e.g. "aabcaab" → 3)
// **Target: O(n)**

func longestPrefixMatchingSuffix(for text: String, nonOverlapping: Bool) -> Int {
    let chars = Array(text)
    let charCount = chars.count
    
    guard charCount > 0 else { return 0 }
    
    var lps: [Int] = .init(repeating: 0, count: charCount)
    var len = 0
    var i = 1
    
    while i < charCount {
        if chars[i] == chars[len] {
            // Match
            len += 1
            lps[i] = len
            i += 1
        } else if len > 0 {
            // No match, regress
            len = lps[len - 1]
        } else {
            // Restart search
            len = 0
            i += 1
        }
    }
    
    // If prefix and suffix are not to overlap:
    if nonOverlapping {
        var borderLength = lps[charCount - 1]
        while borderLength > 0 && borderLength * 2 > charCount {
            borderLength = lps[borderLength - 1]
        }
        return borderLength
    } else {
        return lps.last ?? 0
    }
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("basic", longestPrefixMatchingSuffix(for: "aabaab", nonOverlapping: false), 3)
check("all-same-char", longestPrefixMatchingSuffix(for: "aaaa", nonOverlapping: false), 3)
check("all-same-char, longer", longestPrefixMatchingSuffix(for: "aaaaa", nonOverlapping: false), 4)
check("all-same-char, odd length", longestPrefixMatchingSuffix(for: "aaa", nonOverlapping: false), 2)
check("two chars", longestPrefixMatchingSuffix(for: "aa", nonOverlapping: false), 1)
check("repeated block", longestPrefixMatchingSuffix(for: "abcabc", nonOverlapping: false), 3)
check("longer all-same-char run", longestPrefixMatchingSuffix(for: "aaaaaa", nonOverlapping: false), 5)
check("alternating pattern", longestPrefixMatchingSuffix(for: "abababab", nonOverlapping: false), 6)
check("no border at all", longestPrefixMatchingSuffix(for: "abcde", nonOverlapping: false), 0)
check("single char", longestPrefixMatchingSuffix(for: "a", nonOverlapping: false), 0)
check("empty string", longestPrefixMatchingSuffix(for: "", nonOverlapping: false), 0)

// overlap disallowed (nonOverlapping: true) — capped so prefix/suffix don't share indices
check("basic, unaffected", longestPrefixMatchingSuffix(for: "aabaab", nonOverlapping: true), 3)
check("all-same-char, capped down", longestPrefixMatchingSuffix(for: "aaaa", nonOverlapping: true), 2)
check("all-same-char, longer, capped down", longestPrefixMatchingSuffix(for: "aaaaa", nonOverlapping: true), 2)
check("all-same-char, odd length, capped down", longestPrefixMatchingSuffix(for: "aaa", nonOverlapping: true), 1)
check("two chars, touches exactly (no overlap)", longestPrefixMatchingSuffix(for: "aa", nonOverlapping: true), 1)
check("repeated block, unaffected (touches exactly)", longestPrefixMatchingSuffix(for: "abcabc", nonOverlapping: true), 3)
check("longer all-same-char run, capped down", longestPrefixMatchingSuffix(for: "aaaaaa", nonOverlapping: true), 3)
check("alternating pattern, capped down", longestPrefixMatchingSuffix(for: "abababab", nonOverlapping: true), 4)
check("no border at all, unaffected", longestPrefixMatchingSuffix(for: "abcde", nonOverlapping: true), 0)
check("single char, unaffected", longestPrefixMatchingSuffix(for: "a", nonOverlapping: true), 0)
check("empty string, unaffected", longestPrefixMatchingSuffix(for: "", nonOverlapping: true), 0)
