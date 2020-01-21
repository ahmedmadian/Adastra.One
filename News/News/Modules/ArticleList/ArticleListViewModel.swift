//
//  ArticleListViewModel.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleListViewModel {
    
    let loaded: AnyObserver<Void>
    let reload: AnyObserver<Void>
    
    let data: Observable<[ArticleViewModel]>
    let title: Observable<String>
    let articleRepository: ArticleRepository
    
    let loadedData = BehaviorRelay<[ArticleViewModel]>(value: [])
    
    init(dataRepo: ArticleRepository) {
        self.articleRepository = dataRepo
        self.title = Observable.just("Top Headlines")
        //self.data = articleRepository.
        
        let _loaded = PublishSubject<Void>()
        self.loaded = _loaded.asObserver()
        
        let _reload = PublishSubject<Void>()
        self.reload = _reload.asObserver()
        
        data = loadedData.asObservable()
        
        let loadNext = _loaded.flatMapLatest { _ -> Observable<[ArticleViewModel]> in
            return self.articleRepository.fetchTopHeadlines()
                .map{ $0.map { ArticleViewModel(article: $0) } }
        }
        
        _ = loadNext.subscribe(onNext: { (articles) in
            self.loadedData.accept(self.loadedData.value + articles)
        })
    }
    
}
