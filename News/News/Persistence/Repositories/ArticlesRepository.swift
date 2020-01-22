//
//  ArticlesRepository.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol ArticleRepository {
    func fetchTopHeadlines() -> Observable<[Article]>
    func fetchTopHeadlines(with sourceId: String) -> Observable<[Article]>
}

class ArticlesDataRepository: ArticleRepository{
    
    
    //MARK:- Properties
    private let remoteDataSource: NewsAPIServiceable
    
    // MARK:- Initializers
    init(remoteDataSource: NewsAPIServiceable) {
        self.remoteDataSource = remoteDataSource
    }
    
    //MARK:- Methods
    func fetchTopHeadlines() -> Observable<[Article]> {
        let endPoint: NewsAPIEndPoints = .topHeadlines
        return self.remoteDataSource.fetchArticles(with: endPoint, with: nil)
    }
    
    func fetchTopHeadlines(with sourceId: String) -> Observable<[Article]> {
        let endPoint: NewsAPIEndPoints = .topHeadlines
        let params = ["sources": sourceId]
        return self.remoteDataSource.fetchArticles(with: endPoint, with: params)
    }
    
       
}
