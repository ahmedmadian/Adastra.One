//
//  NewsAPIEndpoints.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

enum NewsAPIEndPoints: Endpointable {
    
    case topHeadlines
    case sources
    
    //MARK:- Properties
    var name: String {
        switch self {
        case .topHeadlines:
            return "top-headlines"
        case .sources:
            return "sources"
        }
    }
    
    private var schema: HTTPSchema {
        switch self {
        default :
            return .HTTPS
        }
    }
    
    private var host: String {
        switch self {
        default :
            return "newsapi.org"
        }
    }
    
    private var path: String {
        switch self {
        default :
            return "v2"
        }
    }
    
    private var base: String {
        switch self {
        default:
            return "\(schema.rawValue)://\(host)"
        }
    }
    
    var fullURL: String {
        switch self {
        default :
            return "\(self.base)/\(self.path)/\(self.name)"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .topHeadlines:
            return [:]
        case .sources:
            return [:]
        }
    }
    
    var headers: [String: String] {
        return [ HeaderParameterKeys.APIKey : HeaderParameterValues.APIKey]
    }
    
    var method: HTTPMethod {
        switch self {
        case .topHeadlines:
            return .get
        case .sources:
            return .get
        }
    }
}
