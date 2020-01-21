//
//  Endpointable.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol Endpointable {
    var name: String { get }
    var parameters: [String : Any] { get }
    var headers: [String : String] { get }
    var fullURL: String { get }
    var method: HTTPMethod { get }
}
