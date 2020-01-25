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
    
    // MARK: - Input
    var loaded: PublishSubject<Void>
    var exit: PublishSubject<Void>
    var openSafari: PublishSubject<Void>
    
    // MARK: - Output
    var articleDetail: BehaviorRelay<ArticleViewModel>
    var collectionData: Observable<[ArticleViewModel]>
    
    // MARK: - Dependancies
    private let articleRepository: ArticleRepository
    
    init(router: UnownedRouter<AppStartUpRoute>, detailedData: ArticleViewModel, dataRepo: ArticleRepository) {
        
        /// Init Dependancies
        self.articleRepository = dataRepo
        
        /// Init Inputs
        self.loaded = PublishSubject<Void>().asObserver()
        exit = PublishSubject<Void>().asObserver()
        openSafari = PublishSubject<Void>().asObserver()
        
        /// Init Outputs
        self.articleDetail = BehaviorRelay<ArticleViewModel>(value: detailedData)
        collectionData = Observable.of([])
        
        collectionData = collectionData.flatMapLatest { _ -> Observable<[ArticleViewModel]> in
            return self.articleRepository.fetchTopHeadlines(with: self.articleDetail.value.sourceId!)
                .map{ $0.map { ArticleViewModel(article: $0) } }
        }
        
        _ = exit.subscribe(onNext: {router.trigger(.exit)})
        
        _ = openSafari.subscribe(onNext: {
            if let url = URL(string: self.articleDetail.value.url) {
                router.trigger(.safari(url: url))
            }
        })
    }
    
    
}
