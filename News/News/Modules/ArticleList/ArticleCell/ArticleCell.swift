//
//  ArticleCell.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    //MARK:- IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var puplishedDateLabel: UILabel!
    
    
    func configCellAppearnce(with viewModel: ArticleViewModel) {
    }
    
}
