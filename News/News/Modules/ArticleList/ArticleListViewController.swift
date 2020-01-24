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
    
    // MARK: - Properties
    var viewModel: ArticleListViewModelType!
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
 
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        congifTableView()
    }
    
    // MARK: - Methods
    func bindViewModel() {
        
        /// View Controller UI actions to the View Model
        
        viewModel.output.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.output.data
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .bind(to: tableView.rx.items(cellIdentifier: ArticleCell.typeName, cellType: ArticleCell.self)) { item, data, cell in
                cell.configCellAppearnce(with: data)
        }.disposed(by: disposeBag)
        
        viewModel.output.errorMessage
            .subscribe(onNext: {
                self.refreshControl.endRefreshing()
                self.presentAlert(message: $0)
            })
            .disposed(by: disposeBag)
        
        // View Controller UI actions to the View Model
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.loaded)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ArticleViewModel.self)
            .bind(to: viewModel.input.selectedArticle)
            .disposed(by: disposeBag)
        
        
        refreshControl.sendActions(for: .valueChanged)
    }
    
    private func congifTableView() {
        let articalNib = UINib(nibName: ArticleCell.typeName, bundle: nil)
        tableView.register(articalNib, forCellReuseIdentifier: ArticleCell.typeName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
        tableView.addSubview(refreshControl)
    }

}
