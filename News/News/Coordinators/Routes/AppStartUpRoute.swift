//
//  AppStartUpRoute.swift
//  News
//
//  Created by Ahmed Madian on 1/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator

enum AppStartUpRoute: Route {
    case articles
    case detail(detailedData: ArticleViewModel)
    case exit
    case safari(url: URL)
}
