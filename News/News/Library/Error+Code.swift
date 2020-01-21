//
//  Error+Code.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

let KErrorInternetConnection = -1009

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
    
    func isNoInternet() -> Bool {
        return self.code == KErrorInternetConnection
    }
}
