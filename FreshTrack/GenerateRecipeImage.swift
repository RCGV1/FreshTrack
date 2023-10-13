import Foundation

struct PixabayResponse: Codable {
    let hits: [PixabayImage]
}

struct PixabayImage: Codable {
    let largeImageURL: String
}

enum ImageURLError: Error {
    case invalidURL
    case noData
    case decodingError
    case noImageFound
}

func getImageURL(for searchTerm: String) -> Result<String, ImageURLError> {
    let apiKey = Credentials.pixabayApiKey
    let baseURL = "https://pixabay.com/api/"
    let query = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let urlString = "\(baseURL)?key=\(apiKey)&q=\(query)&image_type=photo"

    guard let url = URL(string: urlString) else {
        return .failure(.invalidURL)
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let pixabayResponse = try decoder.decode(PixabayResponse.self, from: data)
        if let firstImage = pixabayResponse.hits.first {
            return .success(firstImage.largeImageURL)
        } else {
            return .failure(.noImageFound)
        }
    } catch {
        return .failure(.decodingError)
    }
}
