// Given a string, determine if it's a palindrome, ignoring non-alphanumeric characters.
// **Target: O(n)**

func isPalindrome(_ text: String) -> Bool {
    let chars = Array(text.lowercased()).filter { $0.isLetter || $0.isNumber }
    
    var i = 0, j = chars.count - 1
    while i < j {
        if chars[i] != chars[j] {
            return false
        }
        i += 1
        j -= 1
    }
    
    return true
}

func check<T: Equatable>(_ name: String, _ actual: T, _ expected: T) {
    print(actual == expected ? "pass" : "fail", "-", name)
}

check("classic mixed punctuation/case",
      isPalindrome("A man, a plan, a canal: Panama"), true)

check("classic non-palindrome",
      isPalindrome("race a car"), false)

check("empty string — vacuously true",
      isPalindrome(""), true)

check("single character",
      isPalindrome("a"), true)

check("punctuation only — no alnum chars to compare",
      isPalindrome(".,!"), true)

check("digit vs letter mismatch (the '0P' gotcha)",
      isPalindrome("0P"), false)

check("numeric palindrome",
      isPalindrome("12321"), true)

check("classic mixed punctuation/case, longer",
      isPalindrome("Was it a car or a cat I saw?"), true)

check("whitespace only — vacuously true",
      isPalindrome(" "), true)
