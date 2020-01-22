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

class ArticleListViewModel: ArticleListViewModelType, ArticleListViewModelInput, ArticleListViewModelOutput{
   
    // Input
    var loaded: AnyObserver<Void>
    
    var reload: AnyObserver<Void>

    var selectedArticle: AnyObserver<ArticleViewModel>

    // Output
    var data: Observable<[ArticleViewModel]>
    
    var title: Observable<String>
    
    var loading: Observable<Bool>
    
    
//    let loaded: AnyObserver<Void>
//    let reload: AnyObserver<Void>
//    let selectedArticle: AnyObserver<ArticleViewModel>
//
//    let data: Observable<[ArticleViewModel]>
//    let title: Observable<String>
//    let loading: Observable<Bool>
    let articleRepository: ArticleRepository
    
    /// Emits an url of repository page to be shown.
    let openDetail: Observable<ArticleViewModel>
    
    let loadedData = BehaviorRelay<[ArticleViewModel]>(value: [])
    
    init(dataRepo: ArticleRepository) {
        self.articleRepository = dataRepo
        self.title = Observable.just("Top Headlines")
        
        let _loaded = PublishSubject<Void>()
        self.loaded = _loaded.asObserver()
        
        let _reload = PublishSubject<Void>()
        self.reload = _reload.asObserver()
        
        let _selectedArticle = PublishSubject<ArticleViewModel>()
               self.selectedArticle = _selectedArticle.asObserver()
        
        self.openDetail = _selectedArticle.asObserver().map {$0}
        
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asObservable()
        
        data = loadedData.asObservable()
        
        let loadNext = _loaded.flatMapLatest { _ -> Observable<[ArticleViewModel]> in
            return self.articleRepository.fetchTopHeadlines()
                .trackActivity(activityIndicator)
                .map{ $0.map { ArticleViewModel(article: $0) } }
        }
        
        _ = loadNext.subscribe(onNext: { (articles) in
            self.loadedData.accept(self.loadedData.value + articles)
        })
        
        
    }
    
}
