//
//  ArticleDetailViewModel.swift
//  News
//
//  Created by Ahmed Madian on 1/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

class ArticleDetailViewModel {
    
    private let data: Observable<ArticleViewModel>
    
    init(data: Observable<ArticleViewModel>) {
        self.data = data
    }
    
    
}
