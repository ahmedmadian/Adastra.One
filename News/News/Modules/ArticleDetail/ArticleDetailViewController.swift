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
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var safariButton: UIBarButtonItem!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    var viewModel: ArticleDetailViewModelType!
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureCollectionView()
    }
    
    // MARK:- Methods
    func bindViewModel() {
        
        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .take(1)
            .map { _ in }
            .bind(to: viewModel.input.loaded).disposed(by: disposeBag)
        
        exitButton.rx.tap
            .bind(to: viewModel.input.exit)
            .disposed(by: disposeBag)
        
        safariButton.rx.tap
            .bind(to: viewModel.input.openSafari)
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(ArticleViewModel.self)
            .bind(to: viewModel.output.articleDetail)
        .disposed(by: disposeBag)
        
        
        viewModel.output.articleDetail
            .subscribe(onNext: { (article) in self.fillDetails(with: article) })
            .disposed(by: disposeBag)
        
        viewModel.output.collectionData
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: ArticleCollectionCell.typeName, cellType: ArticleCollectionCell.self)) { item, data, cell in
                cell.configCellAppearnce(with: data)
        }.disposed(by: disposeBag)
        
    }
    
    private func fillDetails(with viewModel: ArticleViewModel) {
        articleImage.sd_setImage(with: URL(string: viewModel.posterImageURL), placeholderImage: nil)
        headlineLabel.text = viewModel.headline
        authorLabel.text = "by: \(viewModel.authorName)"
        descriptionLabel.text = viewModel.articleDescription
        sourceLabel.text = "more from '\(viewModel.sourceName)'"
    }
    
    private func registerCell() {
        let articleCollectionNib = UINib(nibName: ArticleCollectionCell.typeName, bundle: nil)
        collectionView.register(articleCollectionNib, forCellWithReuseIdentifier: ArticleCollectionCell.typeName)
    }
    
    private func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let itemWidth = collectionView.bounds.width/2 - 20
        let itemHeight = collectionView.bounds.height
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
}
