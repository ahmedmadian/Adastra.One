//
//  ArticleCell.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {
    //MARK:- IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var puplishedDateLabel: UILabel!
    
    
    func configCellAppearnce(with viewModel: ArticleViewModel) {
        articleImageView.makeRoundedCorners(with: 15.0)
        containerView.makeRoundedCorners(with: 20)
        articleImageView.sd_setImage(with: URL(string: viewModel.posterImageURL), placeholderImage: nil)
        self.headlineLabel.text = viewModel.headline
        self.puplishedDateLabel.text = viewModel.date
        animateCell()
    }
    
    private func animateCell() {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        self.layer.transform = rotationTransform
        self.alpha = 0.5
        UIView.animate(withDuration: 1.0) {
            self.layer.transform = CATransform3DIdentity
            self.alpha = 1.0
        }
    }
}
