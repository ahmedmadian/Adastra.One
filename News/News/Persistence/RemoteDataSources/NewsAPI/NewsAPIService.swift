//
//  NewsAPIService.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol NewsAPIServiceable: BaseRemoteService {
    func fetchArticles(with endPoint: Endpointable, with parameters: [String: Any]?) -> Observable<[Article]>
}

class NewsAPISerivce: NewsAPIServiceable {
    
    //MARK:- Properties
    static let shared = NewsAPISerivce()
    
    // MARK:- Initializers
    private init() {}
    
    //MARK:- Remote Data Source
    func fetchArticles(with endPoint: Endpointable, with parameters: [String: Any]?) -> Observable<[Article]> {
        return Observable.create { observer in
            self.execute(endPoint: endPoint, parameters: parameters) { (result: Result<ArticleResponseWrapper, Error>) in
                switch result {
                case .success(let response):
                    observer.on(.next(response.articles))
                    observer.on(.completed)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
             return Disposables.create()
        }
    }
}


class ArticleResponseWrapper: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
