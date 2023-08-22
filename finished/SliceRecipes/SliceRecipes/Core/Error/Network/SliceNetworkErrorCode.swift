import Foundation

enum SliceNetworkErrorCode: SliceErrorCode {
    case noData
    case noResponse
    case invalidUrl
    case badRequest(String)
    case noInternetConnection
    case responseBodyParseError
    
    var localizedMessage: String {
        switch self {
        case .noData:
            return "No data Found"
        case .noResponse:
            return "Bad response"
        case .invalidUrl:
            return "Invalid URL"
        case .badRequest(let message):
            return message
        case .noInternetConnection:
            return "No internet connection"
        case .responseBodyParseError:
            return "Couldn't get data from the server"
        }
    }
}
