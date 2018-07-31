//
//  Network.swift
//  SpeedrunApp
//
//  Created by Rodrigo Nunes on 29/7/18.
//  Copyright © 2018 Rodrigo Nunes Gil. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class Network: SessionManager {
    
    static let shared = Network()
    static let statusCodeMinError = 300
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        super.init(configuration: configuration)
    }
    
    private func setupHeaders(request: NetworkRequest) -> [String : String] {
        var headers = request.headers ?? [:]
        
        headers[Api.headerContentTypeKey] = Api.headerContentTypeValue
        headers[Api.headerAcceptedLanguage] = Locale.current.languageCode!
        
        return headers
    }
    
    func requestObject<T: Mappable>(networkRequest: NetworkRequest, completion:@escaping((T?, Error?) -> Void)) {
        let headers = setupHeaders(request: networkRequest)
        
        Alamofire.request(networkRequest.url, method: networkRequest.method, parameters: networkRequest.parameters, encoding: networkRequest.encoding(), headers: headers).validate().responseJSON { (response) in
            
            if let error = response.error {
                completion(nil, error)
            } else {
                if let JSON = response.data {
                    let parsedObject = Mapper<T>().map(JSONObject: JSON)
                    completion(parsedObject, nil)
                }
            }
        }
    }
    
    func requestArray<T: Mappable>(networkRequest: NetworkRequest, completion:@escaping(([T]?, Error?) -> Void)) {
        let headers = setupHeaders(request: networkRequest)
        
        Alamofire.request(networkRequest.url, method: networkRequest.method, parameters: networkRequest.parameters, encoding: networkRequest.encoding(), headers: headers).validate().responseJSON { (response) in
            
            if let error = response.error {
                completion(nil, error)
            } else {
                if let JSON = response.data {
                    let parsedObject = Mapper<T>().mapArray(JSONObject: JSON)
                    completion(parsedObject, nil)
                }
            }
        }

    }
    
    
}


