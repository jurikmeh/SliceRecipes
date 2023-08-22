import Foundation

protocol EndpointType {
    var path: String { get }
    var queryParameters: [URLQueryItem]? { get }
    var bodyParameters: [String : Any]? { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String : String]? { get }
}

extension EndpointType {
    var bodyParameters: [String : Any]? { nil }
    var queryParameters: [URLQueryItem]? { nil }
    var headers: [String : String]? { nil }
}
