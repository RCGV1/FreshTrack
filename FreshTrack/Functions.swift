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


func generateEmoji(foodName: String) -> String {
    do {
        let model = try nameToEmoji__v2(configuration: MLModelConfiguration())
        let inputFeatures = nameToEmoji__v2Input(Food_Name: foodName)
        let prediction = try model.prediction(input: inputFeatures)
        return prediction.Emoji
    } catch {
        return "🍽"
    }
}
