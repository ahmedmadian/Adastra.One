//
//  BaseRemoteService.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Alamofire

protocol BaseRemoteService {
    func execute<Model:Codable>(endPoint: Endpointable, completionHandler: @escaping (Swift.Result<Model, Error>) -> Void )
}

extension BaseRemoteService {
    func execute<Model:Codable>(endPoint: Endpointable, completionHandler: @escaping (Swift.Result<Model, Error>) -> Void ) {
        
        var generalParameters: [String:Any] = [
            NewsAPIParameterKeys.PageSize: "50",
            NewsAPIParameterKeys.Language: "en"
        ]
        
        generalParameters.merge(with: endPoint.parameters)
        
        var generalHeaders = [String: String]()
        generalHeaders.merge(with: endPoint.headers)
        
        Alamofire.request(endPoint.fullURL, method: Alamofire.HTTPMethod.init(rawValue: endPoint.method.rawValue)!, parameters: generalParameters, headers: generalHeaders).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(Model.self, from: data)
                    completionHandler(Swift.Result.success(object))
                }
                catch {
                    completionHandler(Swift.Result.failure(BaseServiceError.parsingError))
                }
            case .failure(let error):
                completionHandler(Swift.Result.failure(BaseServiceError.serverError(message: error.localizedDescription, code: error.code)))
            }
        }
    }
}
