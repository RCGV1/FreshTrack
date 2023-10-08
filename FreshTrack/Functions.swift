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


