import Foundation
import Alamofire

class OpenAIService {
    
    let baseUrl = "https://api.openai.com/v1/engines/text-davinci-003/completions"
    var response: String = ""
    
    func sendRequest(message: String, completion: @escaping (String) -> Void) {
        let body = OpenAICompletionsBody(prompt: message, max_tokens: 500) // Adjust max_tokens as needed

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Credentials.openaiApiKey)"
        ]

        AF.request(baseUrl, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers).validate()
            .responseDecodable(of: ResponseModel.self) { response in
                switch response.result {
                case .success(let model):
                    // Handle the response from the GPT service here
                    let generatedText = model.choices[0].text
                    completion(generatedText) // Call the completion closure with the generated text
                case .failure(let error):
                    print("Error: \(error)")
                    completion("") // Handle the error case by passing an empty string
                }
            }
    }
}

struct OpenAICompletionsBody: Encodable {
    let prompt: String
    let max_tokens: Int
}

struct ResponseModel: Decodable {
    let choices: [Choice]
}

struct Choice: Decodable {
    let text: String
}
