//
//  ArticleCollectionCell.swift
//  News
//
//  Created by Ahmed Madian on 1/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCollectionCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var artilceImage: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    
    func configCellAppearnce(with viewModel: ArticleViewModel){
        artilceImage.makeRoundedCorners(with: 30)
        containerView.makeRoundedCorners(with: 20)
        artilceImage.sd_setImage(with: URL(string:viewModel.posterImageURL), placeholderImage: nil)
        headlineLabel.text = viewModel.headline
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
