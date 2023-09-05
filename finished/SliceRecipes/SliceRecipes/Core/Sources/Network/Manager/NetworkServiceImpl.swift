import Foundation
import Error
import Utils

public final class NetworkServiceImpl: NetworkService {
    private let session: URLSession
    private let getApiHostUseCase: GetApiHostUseCase
    
    // MARK: - Init
    public init(getApiHostUseCase: GetApiHostUseCase, session: URLSession = .shared) {
        self.getApiHostUseCase = getApiHostUseCase
        self.session = session
    }
    
    public func executeRequest<T: Codable>(endpoint: EndpointType, completion: @escaping (Result<T, SliceError>) -> Void) {
        guard let url = setupURL(for: endpoint) else {
            completion(.failure(SliceError(code: SliceNetworkErrorCode.invalidUrl)))
            return
        }
        let request = setupRequest(for: endpoint, url: url)
        
        let task = setupDataTask(with: request, completion)
        task?.resume()
    }
}

private extension NetworkServiceImpl {
    func setupURL(for endpoint: EndpointType) -> URL? {
        var urlBuilder = URLComponents()
        var apiHost = getApiHostUseCase.execute()
        urlBuilder.scheme = apiHost.starts(with: "https") ? "https" : "http"
        apiHost = apiHost.replacingOccurrences(of: apiHost.starts(with: "https") ? "https://" : "http://", with: "")
        urlBuilder.path = endpoint.path
        urlBuilder.host = apiHost
        urlBuilder.queryItems = endpoint.queryParameters
        
        return urlBuilder.url
    }
    
    func setupRequest(for endpoint: EndpointType, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        if let parameters = endpoint.bodyParameters {
            let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = data
        }
        if let headers = endpoint.headers {
            headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func setupDataTask<T: Codable>(with request: URLRequest, _ completion: @escaping (Result<T, SliceError>) -> Void) -> URLSessionDataTask? {
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil, let error = error as NSError?, error.code == -1009 || error.code == -1020 {
                completion(.failure(SliceError(code: SliceNetworkErrorCode.noInternetConnection)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(SliceError(code: SliceNetworkErrorCode.noResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(SliceError(code: SliceNetworkErrorCode.noData)))
                return
            }
            
            switch response.statusCode {
            case 200..<300:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(SliceError(code: SliceNetworkErrorCode.responseBodyParseError)))
                }
            default: completion(.failure(SliceError(code: SliceNetworkErrorCode.badRequest("Unknown status code: \(response.statusCode)"))))
            }
        }
        
        return task
    }
}
