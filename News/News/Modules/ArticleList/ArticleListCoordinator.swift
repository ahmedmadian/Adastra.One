//
//  ArticleListCoordinator.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxSwift

class ArticleListCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let articleRepository = ArticlesDataRepository(remoteDataSource: NewsAPISerivce.shared)
        let viewModel = ArticleListViewModel(dataRepo: articleRepository)
        let viewController: ArticleListViewController = Storyboards.main.instantiate()!
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
}
