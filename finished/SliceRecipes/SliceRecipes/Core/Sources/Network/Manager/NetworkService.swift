import Foundation
import Error

public protocol NetworkService {
    func executeRequest<T: Codable>(endpoint: EndpointType, completion: @escaping (Result<T, SliceError>) -> Void)
}
