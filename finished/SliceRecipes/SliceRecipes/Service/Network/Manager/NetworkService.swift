import Foundation

protocol NetworkService {
    func executeRequest<T: Codable>(endpoint: EndpointType, completion: @escaping (Result<T, SliceError>) -> Void)
}
