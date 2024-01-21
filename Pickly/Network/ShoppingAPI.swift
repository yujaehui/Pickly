//
//  ShoppingAPI.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/21/24.
//

import Foundation
import Alamofire

enum ShoppingAPI {
    case search(query: String, start: Int, sort: String)
    
    var baseURL: String {
        return "https://openapi.naver.com/v1/search/shop.json"
    }
    
    var endpoint: URLRequest {
        switch self {
        case .search(query: let query, start: let start, sort: let sort):
            let url = URL(string: baseURL + "?query=\(query)&display=20&start=\(start)&sort=\(sort)")!
            return URLRequest(url: url)
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: HTTPHeaders {
        return ["X-Naver-Client-Id": APIKey.clientID,
                "X-Naver-Client-Secret": APIKey.clientSecret]
    }
}
