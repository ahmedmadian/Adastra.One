//
//  ArticleListCoordinator.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

//import UIKit
//import RxSwift
//
//class ArticleListCoordinator: BaseCoordinator<Void> {
//    
//    private let window: UIWindow
//    
//    init(window: UIWindow) {
//        self.window = window
//    }
//    
//    override func start() -> Observable<Void> {
//        let articleRepository = ArticlesDataRepository(remoteDataSource: NewsAPISerivce.shared)
//        let viewModel = ArticleListViewModel(dataRepo: articleRepository)
//        let viewController: ArticleListViewController = Storyboards.main.instantiate()!
//        let navigationController = self.setupNavigationController(rootViewController: viewController)
//        
//        viewController.viewModel = viewModel
//        
//        viewModel.openDetail.subscribe(onNext: { self.openDetail(by: $0)}).disposed(by: disposeBag)
//
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//        
//        return Observable.never()
//    }
//    
//    private func setupNavigationController(rootViewController:  UIViewController) -> UINavigationController {
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        navigationController.navigationBar.prefersLargeTitles = true
//        return navigationController
//    }
//    
//    private func openDetail(by data: ArticleViewModel) {
//        print(data.headline)
//        
//        //navigationController.pushViewController(detailCoordinator, animated: true)
//    }
//    
//}
