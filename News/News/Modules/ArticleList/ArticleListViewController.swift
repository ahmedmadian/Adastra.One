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

class ArticleListViewController: BaseViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ArticleListViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.showLoader()
        registerCells()
        setupBindings()
    }
    
    private func setupBindings() {
        
        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .take(1)
            .map { _ in }
            .bind(to: viewModel.loaded)
    
        viewModel.loading.subscribe(onNext: { loading in
            if loading {
                self.showLoader()
            } else {
                self.hideLoader()
            }
            }).disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.data
            .observeOn(MainScheduler.instance)
            //.do(onNext: { [weak self] _ in self?.hideLoader() })
            .bind(to: tableView.rx.items(cellIdentifier: ArticleCell.typeName, cellType: ArticleCell.self)) { item, data, cell in
                cell.configCellAppearnce(with: data)
            }.disposed(by: disposeBag)


    }
    
    private func registerCells() {
        let articalNib = UINib(nibName: ArticleCell.typeName, bundle: nil)
        tableView.register(articalNib, forCellReuseIdentifier: ArticleCell.typeName)
    }

}
