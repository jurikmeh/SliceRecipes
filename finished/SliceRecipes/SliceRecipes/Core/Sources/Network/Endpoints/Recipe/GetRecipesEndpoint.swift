import Foundation

public struct GetRecipesEndpoint: EndpointType {
    public let path = "/recipes/list"
    public let httpMethod: HTTPMethod = .GET
    
    public let queryParameters: [URLQueryItem]? = [
        URLQueryItem(name: "from", value: "0"),
        URLQueryItem(name: "size", value: "20"),
        URLQueryItem(name: "tags", value: "under_30_minutes")
    ]
    
    public let headers: [String : String]? = [
        "X-RapidAPI-Key": "a356eca938mshecd748d7e4377d7p18b321jsn5f7a486ec28a",
        "X-RapidAPI-Host": "tasty.p.rapidapi.com"
    ]
    
    public init() {}
}
