//
//  NetworkManager.swift
//
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation

public enum NetworkError: Error {
    
    case invalidRequest
    case requestFailed
    case jsonDecodedError
    case customError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        case .requestFailed:
            return "Request Failed"
        case .jsonDecodedError:
            return "Json Decoded Error"
        case .customError(let error):
            return error.localizedDescription
        }
    }
}

public protocol NetworkService {
    func execute<T: Decodable>(
        urlRequest: URLRequest,
        completion: @escaping(Result<T, NetworkError>) -> Void
    )
}

public class NetworkManager {
    private let session: URLSession
    
    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
}

extension NetworkManager: NetworkService {
    
    public func execute<T: Decodable>(
        urlRequest: URLRequest,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        let task = session.dataTask(with: urlRequest) { data, response, error in

            if let error {
                completion(.failure(NetworkError.customError(error)))
            } else if let data {
                do {
                    let responseObj = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObj))
                } catch {
                    print("JSON parsing error: \(error.localizedDescription)")
            
                    completion(.failure(.jsonDecodedError))
                    completion(.failure(.requestFailed))
                }
            } else {
                completion(.failure(.requestFailed))
            }
            
        }
        
        task.resume()
    }
}

