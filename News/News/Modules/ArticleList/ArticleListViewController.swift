//
//  ArticleListViewController.swift.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
