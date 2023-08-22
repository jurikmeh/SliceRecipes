import Foundation

class NetworkService {
    let headers = [
        "X-RapidAPI-Key": "a356eca938mshecd748d7e4377d7p18b321jsn5f7a486ec28a",
        "X-RapidAPI-Host": "tasty.p.rapidapi.com"
    ]

    func getRecipes(_ completion: @escaping ((ItemList) -> Void)) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=under_30_minutes")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            let decoder = JSONDecoder()
            let items = try! decoder.decode(ItemList.self, from: data!)
            completion(items)
        })
    }
}
