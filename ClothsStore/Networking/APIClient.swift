//
//  APIClient.swift
//  ClothsStore
//
//  Created by Zoombie on 05/04/22.
//

import Foundation


public enum RequestType: String {
    case GET
}

protocol APIRequest {
    var method: RequestType { get }
    var path: String { get }
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard let components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

enum APIError: Error, LocalizedError {
    case someError(reason: String)

    var errorDescription: String? {
        switch self {
        case .someError(let reason):
            return reason
        }
    }
}

//MARK: Request Model

class RequestModel: APIRequest {
    internal init(method: RequestType = RequestType.GET, path: String = "") {
        self.method = method
        self.path = path
    }
    
    var method = RequestType.GET
    var path = ""
}

class APIClient {
    private let baseURL = URL(string: "https://api.npoint.io/")!
    
    func send<T: Codable>(_ apiRequest: APIRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        let request = apiRequest.request(with: self.baseURL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.someError(reason: "API Error")))
                return
            }
            guard let data = data else {
                completion(.failure(.someError(reason: "No Data")))
                return
            }
            do {
                let model: T = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                print(error)
                completion(.failure(.someError(reason: error.localizedDescription)))
            }
        }
        task.resume()
    }
}
