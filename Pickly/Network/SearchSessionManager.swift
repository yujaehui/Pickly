//
//  SearchSessionManager.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import Foundation
import Alamofire

enum ErrorType: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

extension URLSession {
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func customDataTask(_ request: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        let task = dataTask(with: request, completionHandler: completionHandler)
        task.resume()
        return task
    }
}

class SearchSessionManager {
    static let shared = SearchSessionManager()
    private init() {}
    
    func fetchSearch(api: ShoppingAPI) async throws -> Shopping {
        var request = api.endpoint
        request.addValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw ErrorType.invalidResponse }
        let decodedData = try JSONDecoder().decode(Shopping.self, from: data)
        return decodedData
    }
    
    
//    static func request<T: Codable>(_ session: URLSession = .shared, request: URLRequest, completion: @escaping (T?, ErrorType?) -> Void ) {
//        var request = request
//        request.addValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
//        request.addValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
//        session.customDataTask(request) { data, response, error in
//            DispatchQueue.main.async {
//                guard error == nil else {
//                    print("네트워크 통신 실패")
//                    completion(nil, .failedRequest)
//                    return
//                }
//                
//                guard let data = data else {
//                    print("데이터 불러오기 실패")
//                    completion(nil, .noData)
//                    return
//                }
//                
//                guard let response = response as? HTTPURLResponse else {
//                    print("응답 불러오기 실패")
//                    completion(nil, .invalidResponse)
//                    return
//                }
//                
//                guard response.statusCode == 200 else {
//                    print("정확한 응답 실패")
//                    completion(nil, .invalidResponse)
//                    return
//                }
//                
//                do {
//                    let result = try JSONDecoder().decode(T.self, from: data)
//                    dump(result)
//                    completion(result, nil)
//                } catch {
//                    print(error)
//                    completion(nil, .invalidData)
//                }
//            }
//        }
//    }
}
