//
//  NetworkRequest.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 29/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import Alamofire

class NetworkRequest {
    
    var baseUrl: String = Api.baseURL
    var path = ""
    var method: HTTPMethod = .get
    var headers: [String : String]?
    var parameters: [String : Any]?
    var mapper: ((Any) -> (Any?))?
    var url: URLConvertible {
        let fullUrl = baseUrl + path
        return fullUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? fullUrl
    }
    
    init() {}
    
    func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
}
