//
//  AppCoordinator.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let articleListCoordinator = ArticleListCoordinator(window: window)
        return coordinate(to: articleListCoordinator)
    }
    
}
