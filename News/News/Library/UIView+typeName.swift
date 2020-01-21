//
//  UIView+typeName.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

extension UIView {    
    static var typeName: String {
        return String(describing: self)
    }
}
