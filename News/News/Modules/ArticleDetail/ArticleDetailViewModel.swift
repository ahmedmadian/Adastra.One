//
//  ArticleDetailViewModel.swift
//  News
//
//  Created by Ahmed Madian on 1/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import XCoordinator
import RxCocoa

class ArticleDetailViewModel: ArticleDetailViewModelType, ArticleDetailViewModelInput, ArticleDetailViewModelOutput {
   
    
    
    
    
    //Input
    var loaded: PublishSubject<Void>
    var exit: PublishSubject<Void>
    
    //Output
    var articleDetail: Observable<ArticleViewModel>
    var collectionData: Observable<[ArticleViewModel]>
    
    private let data: BehaviorRelay<ArticleViewModel>
    private let loadedData: BehaviorRelay<[ArticleViewModel]>
    private let articleRepository: ArticleRepository
    
    init(router: UnownedRouter<AppStartUpRoute>, detailedData: ArticleViewModel, dataRepo: ArticleRepository) {
        self.articleRepository = dataRepo
        self.data =  BehaviorRelay<ArticleViewModel>(value: detailedData)
        
        let _loaded = PublishSubject<Void>()
        self.loaded = _loaded.asObserver()
        
        self.articleDetail = data.map {$0}
        
        loadedData = BehaviorRelay<[ArticleViewModel]>(value: [])
        
        collectionData = loadedData.asObservable()
        
        exit = PublishSubject<Void>().asObserver()
        
        let loadNext = _loaded.flatMapLatest { _ -> Observable<[ArticleViewModel]> in
            return self.articleRepository.fetchTopHeadlines()
                .map{ $0.map { ArticleViewModel(article: $0) } }
        }
        
       _ = loadNext.subscribe(onNext: { (articles) in
           self.loadedData.accept(self.loadedData.value + articles)
       })
        
        _ = exit.subscribe(onNext: {router.trigger(.exit)})
    }
    
    
}
