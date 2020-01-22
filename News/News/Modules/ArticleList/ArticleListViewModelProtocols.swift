//
//  ArticleListViewModelProtocols.swift
//  News
//
//  Created by Ahmed Madian on 1/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ArticleListViewModelInput {
    var loaded: AnyObserver<Void> {get}
    //var reload: AnyObserver<Void> {get}
    var selectedArticle: PublishSubject<ArticleViewModel> {get}
}

protocol ArticleListViewModelOutput {
    var data: Observable<[ArticleViewModel]> {get}
    var title: Observable<String> {get}
    var loading: Observable<Bool> {get}
}

protocol ArticleListViewModelType {
    var input: ArticleListViewModelInput { get }
    var output: ArticleListViewModelOutput { get }
}

extension ArticleListViewModelType where Self: ArticleListViewModelInput & ArticleListViewModelOutput {
    var input: ArticleListViewModelInput { return self }
    var output: ArticleListViewModelOutput { return self }
}
