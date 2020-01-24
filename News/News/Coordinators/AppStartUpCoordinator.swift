//
//  AppStartUpCoordinator.swift
//  News
//
//  Created by Ahmed Madian on 1/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator
import SafariServices

class AppStartUpCoordinator: NavigationCoordinator<AppStartUpRoute> {
    
    init() {
        super.init(initialRoute: .articles)
        Config(navigationController: self.rootViewController)
    }
    
    ///manage modules transition
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
            
            return .presentFullScreen(viewController, animation: .fade)
            
        case .exit:
            return .dismissToRoot()
        
        case .safari(let url):
            let svc = SFSafariViewController(url: url)
            return .present(svc)
        }
    }
    
    ///setup navigation bar appearnce
    private func Config(navigationController: UINavigationController) {
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.prefersLargeTitles = true
        
        let attributes = [ NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)]
        
        navigationController.navigationBar.titleTextAttributes = attributes
        navigationController.navigationBar.largeTitleTextAttributes = attributes
    }
}
