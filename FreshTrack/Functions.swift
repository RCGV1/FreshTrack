import CoreML
import Foundation


func calculateExpirationDate(daysRemaining: Int) -> String? {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    if let expirationDate = Calendar.current.date(byAdding: .day, value: daysRemaining, to: currentDate) {
        return dateFormatter.string(from: expirationDate)
    } else {
        // Unable to calculate the date (invalid input, etc.)
        return nil
    }
}

let foodEmojiDictionary = [
    "pizza": "🍕",
    "burger": "🍔",
    "taco": "🌮",
    "sushi": "🍣",
    "ice cream": "🍦",
    "spaghetti": "🍝",
    "hot dog": "🌭",
    "french fries": "🍟",
    "popcorn": "🍿",
    "chicken": "🍗",
    "burrito": "🌯",
    "pancakes": "🥞",
    "donut": "🍩",
    "soda": "🥤",
    "shrimp": "🍤",
    "sandwich": "🥪",
    "milk": "🥛",
    "yogurt": "🥛",
    "cheese": "🧀",
    "croissant": "🥐",
    "baguette": "🥖",
    "cupcake": "🧁",
    "hamburger": "🍔",
    "cofee": "☕",
    "bento box": "🍱",
    "chocolate": "🍫",
    "potato": "🥔",
    "carrot": "🥕",
    "peach": "🍑",
    "strawberry": "🍓",
    "watermelon": "🍉",
    "apple": "🍎",
    "banana": "🍌",
    "grapes": "🍇",
    "lemon": "🍋",
    "pineapple": "🍍",
    "avocado": "🥑",
    "kiwi": "🥝",
    "cherries": "🍒",
    "pear": "🍐",
    "sake": "🍶",
    "wine": "🍷",
    "beer": "🍺",
    "cocktail": "🍸",
    "drink": "🍹",
    "chinese": "🥡",
    "egg": "🥚",
    "tomato": "🍅",
    "canned": "🥫",
    "beef": "🥩",
    "meat": "🥩",
    "bell pepper": "🫑",
    "sausage": "🌭",
    "sprout": "🌱",
    "pasta": "🍝"
    
]

func generateEmoji(foodName: String) -> String {

    let lowercaseFoodName = foodName.lowercased()
    for (food, emoji) in foodEmojiDictionary {
        if lowercaseFoodName.contains(food) {
            return emoji
        }
    }
return "🍽️"
}




