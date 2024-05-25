//
//  API.swift
//
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation


public var word: String = ""

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Router {
    case word
    case pronunciation
    case synonym
    
    var path: String {
        switch self{
        case .word:
            return "https://api.dictionaryapi.dev/api/v2/entries/en/"
        case .pronunciation:
            return "/media/pronunciations/en/"
        case .synonym:
            return "https://api.datamuse.com/words?rel_syn="
        }
    }
    
}

public class API {
    
    public static let shared: API = {
        let instance = API()
        return instance
    }()
    
    var baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    private var service: NetworkService
    
    public init(service: NetworkService = NetworkManager()) {

        self.service = service
    }
    
}

extension API {
    
    public func isConnectedToInternet() -> Bool{
        return Reachability.isConnectedToNetwork()
    }
    
    func exequteRequestFor<T: Decodable>(
        router: Router,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        
        if let urlRequest = prepareURLRequestFor(
            router: router,
            parameters: parameters,
            headers: headers,
            method: method
        ) {
            service.execute(urlRequest: urlRequest, completion: completion)
        } else {
            completion(.failure(.invalidRequest))
        }
        
    }
    
    func prepareURLRequestFor(
        router: Router,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get
    ) -> URLRequest? {
        let urlString = router.path + word 
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        
        if let params = parameters {
            if method == .get  {
                guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return nil
                }
                
                let queryItems = params.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
                
                urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
                
                guard let newUrl = urlComponents.url else { return nil }
                
                request = URLRequest(url: newUrl)
            } else {
                let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
            }
        }
        
        request.httpMethod = method.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let requestHeaders = headers {
            for (field, value) in requestHeaders {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
        
        return request
    }
}
