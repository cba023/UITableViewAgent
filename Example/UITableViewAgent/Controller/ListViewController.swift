//
//  ListViewController.swift
//  TableViewAgent_Example
//
//  Created by bo.chen on 2021/6/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ListViewController: UIViewController/*, UITableViewDataSource, UITableViewDelegate*/ {
    
    var tableView: UITableView!
    
    var listViewModel: ListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        tableView = UITableView(frame: .init(origin: .zero, size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height)), style: .grouped)
        view.addSubview(tableView)
        
        listViewModel = ListViewModel(tableView: self.tableView)

        listViewModel.appliances.bind {[weak self] appliances in
            guard let self = self else { return }
            self.listViewModel.display()
        }
        
        listViewModel.news.bind {[weak self] news in
            guard let self = self else { return }
            self.listViewModel.display()
        }
        
        self.listViewModel.display()
    }
    
    deinit {
        print("🟩🟩🟩🟩")
    }
    
    
    
}
