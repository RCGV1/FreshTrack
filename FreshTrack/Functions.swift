import Foundation


func levenshteinDistance(str1: String, str2: String) -> Int {
    let len1 = str1.count
    let len2 = str2.count
    var matrix = [[Int]](repeating: [Int](repeating: 0, count: len2 + 1), count: len1 + 1)
    
    for i in 1...len1 {
        matrix[i][0] = i
    }
    
    for j in 1...len2 {
        matrix[0][j] = j
    }
    
    for (i, char1) in str1.enumerated() {
        for (j, char2) in str2.enumerated() {
            let cost = char1 == char2 ? 0 : 1
            matrix[i + 1][j + 1] = min(
                matrix[i][j + 1] + 1,
                matrix[i + 1][j] + 1,
                matrix[i][j] + cost
            )
        }
    }
    
    return matrix[len1][len2]
}
func findClosestEmoji(for input: String) -> String? {
    let foodEmojis: [String: String] = [
        "apple": "🍎",
        "banana": "🍌",
        "orange": "🍊",
        "strawberry": "🍓",
        "watermelon": "🍉",
        "grapes": "🍇",
        "pineapple": "🍍",
        "lemon": "🍋",
        "peach": "🍑",
        "cherry": "🍒",
        "kiwi": "🥝",
        "avocado": "🥑",
        "tomato": "🍅",
        "carrot": "🥕",
        "broccoli": "🥦",
        "corn": "🌽",
        "cucumber": "🥒",
        "eggplant": "🍆",
        "bell pepper": "🫑",
        "mushroom": "🍄",
        "garlic": "🧄",
        "onion": "🧅",
        "potato": "🥔",
        "sweet potato": "🍠",
        "bread": "🍞",
        "croissant": "🥐",
        "baguette": "🥖",
        "pancake": "🥞",
        "hamburger": "🍔",
        "pizza": "🍕",
        "hotdog": "🌭",
        "taco": "🌮",
        "burrito": "🌯",
        "sushi": "🍣",
        "rice ball": "🍙",
        "noodle": "🍜",
        "spaghetti": "🍝",
        "cake": "🍰",
        "cupcake": "🧁",
        "ice cream": "🍦",
        "donut": "🍩",
        "cookie": "🍪",
        "chocolate bar": "🍫",
        "candy": "🍬",
        "lollipop": "🍭",
        "coffee": "☕️",
        "tea": "🍵",
        "soda": "🥤",
        "beer": "🍺",
        "wine": "🍷",
        "cocktail": "🍹",
        "fork and knife": "🍴",
        "plate": "🍽",
        "bowl": "🥣",
        "chopsticks": "🥢"
    ]
    
    var minDistance = Int.max
    var closestMatch: String?
    
    for (foodItem, emoji) in foodEmojis {
        let distance = levenshteinDistance(str1: input.lowercased(), str2: foodItem.lowercased())
        if distance < minDistance {
            minDistance = distance
            closestMatch = emoji
        }
    }
    
    return closestMatch
    
}

