//
//  ArticleDetailViewController.swift
//  News
//
//  Created by Ahmed Madian on 1/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage

class ArticleDetailViewController: UIViewController, BindableType {
   
    //MARK: - Outlets
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    private let disposeBag = DisposeBag()
    var viewModel: ArticleDetailViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        
        viewModel.output.articleDetail.subscribe(onNext: { (article) in
            self.fillDetails(with: article)
        }).disposed(by: disposeBag)
        
        
    }
    
    private func fillDetails(with viewModel: ArticleViewModel) {
        articleImage.sd_setImage(with: URL(string: viewModel.posterImageURL), placeholderImage: nil)
        headlineLabel.text = viewModel.headline
        authorLabel.text = viewModel.authorName
        descriptionLabel.text = viewModel.articleDescription
    }
}
