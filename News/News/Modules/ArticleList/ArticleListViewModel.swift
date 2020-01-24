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
    var loaded: PublishSubject<Void>
    var selectedArticle: PublishSubject<ArticleViewModel>

    //MARK:- Output
    /// View Model outputs to the View Controller
    var data: Observable<[ArticleViewModel]>
    var title: Observable<String>
    var loading: Observable<Bool>
    var errorMessage: Observable<String>
    
    // MARK:- Properties
    private var router: UnownedRouter<AppStartUpRoute>
    private let articleRepository: ArticleRepository
    
    private let loadedData: BehaviorRelay<[ArticleViewModel]>
    
    init(router: UnownedRouter<AppStartUpRoute>, dataRepo: ArticleRepository) {
        self.router = router
        self.articleRepository = dataRepo
        loadedData = BehaviorRelay<[ArticleViewModel]>(value: [])
        
        self.title = Observable.just("Top Headlines")
        
        self.loaded = PublishSubject<Void>().asObserver()
        
        self.selectedArticle = PublishSubject<ArticleViewModel>().asObserver()
        
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asObservable()
        
        let _errorMessage = PublishSubject<String>()
        self.errorMessage = _errorMessage.asObservable()
        
        data = loadedData.asObservable()
        
        self.data = loaded.flatMapLatest { _ -> Observable<[ArticleViewModel]> in
            return self.articleRepository.fetchTopHeadlines()
                .trackActivity(activityIndicator)
            .catchError { error in
                _errorMessage.onNext(error.localizedDescription)
                return Observable.empty()
            }
                .map{ $0.map { ArticleViewModel(article: $0) } }
        }
        
        _ = selectedArticle.subscribe(onNext: {router.trigger(.detail(detailedData: $0))})
        
    }
    
}
