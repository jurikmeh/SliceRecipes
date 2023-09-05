import Foundation

public protocol EndpointType {
    var path: String { get }
    var queryParameters: [URLQueryItem]? { get }
    var bodyParameters: [String : Any]? { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String : String]? { get }
}

extension EndpointType {
    public var bodyParameters: [String : Any]? { nil }
    public var queryParameters: [URLQueryItem]? { nil }
    public var headers: [String : String]? { nil }
}
