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
    func fetchArticles(with endPoint: Endpointable) -> Observable<[Article]>
}

class NewsAPIRemoteDataSource: NewsAPIServiceable {
    
    //MARK:- Properties
    static let shared = NewsAPIRemoteDataSource()
    
    // MARK:- Initializers
    private init() {}
    
    //MARK:- Remote Data Source
    func fetchArticles(with endPoint: Endpointable) -> Observable<[Article]> {
        return Observable.create { observer in
            self.execute(endPoint: endPoint) { (result: Result<ArticleResponseWrapper, Error>) in
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
