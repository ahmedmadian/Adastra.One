//
//  ArticleDetailViewModelProtocol.swift
//  News
//
//  Created by Ahmed Madian on 1/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ArticleDetailViewModelInput {
     var loaded: PublishSubject<Void> {get}
    var exit: PublishSubject<Void> {get}
}

protocol ArticleDetailViewModelOutput {
    var articleDetail: Observable<ArticleViewModel> {get}
    //var imageUrl: Observable<String> {get}
    var collectionData: Observable<[ArticleViewModel]> {get}
}

protocol ArticleDetailViewModelType {
    var input: ArticleDetailViewModelInput { get }
    var output: ArticleDetailViewModelOutput { get }
}

extension ArticleDetailViewModelType where Self: ArticleDetailViewModelInput & ArticleDetailViewModelOutput {
    var input: ArticleDetailViewModelInput { return self }
    var output: ArticleDetailViewModelOutput { return self }
}
