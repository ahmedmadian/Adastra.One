//
//  ArticleListViewController.swift.swift
//  News
//
//  Created by Ahmed Madian on 1/21/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleListViewController: BaseViewController, BindableType {
    
    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ArticleListViewModelType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congifTableView()
    }
    
    func bindViewModel() {
        
        // View Controller UI actions to the View Model
        
        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .take(1)
            .map { _ in }
            .bind(to: viewModel.input.loaded)
        
        tableView.rx.modelSelected(ArticleViewModel.self)
            .bind(to: viewModel.input.selectedArticle)
            .disposed(by: disposeBag)
        
        
        // View Controller UI actions to the View Model

        viewModel.output.loading.subscribe(onNext: { loading in
            if loading {
                self.showLoader()
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
        
        viewModel.output.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.output.data
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: ArticleCell.typeName, cellType: ArticleCell.self)) { item, data, cell in
                cell.configCellAppearnce(with: data)
        }.disposed(by: disposeBag)
        
        
        viewModel.output.errorMessage.subscribe(onNext: { self.presentAlert(message: $0)}).disposed(by: disposeBag)
    }
    
    private func congifTableView() {
        let articalNib = UINib(nibName: ArticleCell.typeName, bundle: nil)
        tableView.register(articalNib, forCellReuseIdentifier: ArticleCell.typeName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
    }

}
