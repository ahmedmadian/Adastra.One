//
//  ArticleListViewModel.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import XCoordinator
import RxCocoa

class ArticleListViewModel: ArticleListViewModelType, ArticleListViewModelInput, ArticleListViewModelOutput{
   
    //MARK:-  Input
    /// View Controller UI actions to the View Model
    var loaded: AnyObserver<Void>
    var selectedArticle: PublishSubject<ArticleViewModel>

    //MARK:- Output
    /// View Model outputs to the View Controller
    var data: Observable<[ArticleViewModel]>
    var title: Observable<String>
    var loading: Observable<Bool>
    
    // MARK:- Properties
    var router: UnownedRouter<AppStartUpRoute>
    private let articleRepository: ArticleRepository
    
    private let loadedData: BehaviorRelay<[ArticleViewModel]>
    
    init(router: UnownedRouter<AppStartUpRoute>, dataRepo: ArticleRepository) {
        self.router = router
        self.articleRepository = dataRepo
        loadedData = BehaviorRelay<[ArticleViewModel]>(value: [])
        
        self.title = Observable.just("Top Headlines")
        
        let _loaded = PublishSubject<Void>()
        self.loaded = _loaded.asObserver()
        
        
        let _selectedArticle = PublishSubject<ArticleViewModel>()
        self.selectedArticle = _selectedArticle.asObserver()
        
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
        
        let _openDetailWithSelectedModel = PublishSubject<ArticleViewModel>()
        self.selectedArticle = _openDetailWithSelectedModel.asObserver()
        
        _ = _openDetailWithSelectedModel.subscribe(onNext: {print($0.headline)})
        
    }
    
}
