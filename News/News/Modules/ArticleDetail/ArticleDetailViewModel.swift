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
    //var loaded: PublishSubject<Void>
    
    //Output
    var articleDetail: Observable<ArticleViewModel>
    
    
    private let data: BehaviorRelay<ArticleViewModel>
    
    init(router: UnownedRouter<AppStartUpRoute>, detailedData: ArticleViewModel) {
        self.data =  BehaviorRelay<ArticleViewModel>(value: detailedData)
        
        //let _loaded = PublishSubject<Void>()
        //self.loaded = _loaded.asObserver()
        
        self.articleDetail = data.map {$0}
    }
    
    
}
