//
//  AppStartUpCoordinator.swift
//  News
//
//  Created by Ahmed Madian on 1/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator

class AppStartUpCoordinator: NavigationCoordinator<AppStartUpRoute> {
    
    init() {
        super.init(initialRoute: .articles)
    }
    
    override func prepareTransition(for route: AppStartUpRoute) -> NavigationTransition {
        switch route {
        
        case .articles:
            let articleRepository = ArticlesDataRepository(remoteDataSource: NewsAPISerivce.shared)
            let viewModel = ArticleListViewModel(router: self.unownedRouter, dataRepo: articleRepository)
            let viewController: ArticleListViewController = Storyboards.main.instantiate()!
            viewController.bind(to: viewModel)
            
            return .push(viewController)
            
        case .detail(let detailedData):
            let articleRepository = ArticlesDataRepository(remoteDataSource: NewsAPISerivce.shared)
            let viewModel = ArticleDetailViewModel(router: self.unownedRouter, detailedData: detailedData, dataRepo: articleRepository)
            let viewController: ArticleDetailViewController = Storyboards.main.instantiate()!
            viewController.bind(to: viewModel)
            return .push(viewController)
        }
    }
    
}
