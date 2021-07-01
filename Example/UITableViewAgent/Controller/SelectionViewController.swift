//
//  SelectionViewController.swift
//  UITableViewAgent_Example
//
//  Created by 陈波 on 2021/7/1.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import UITableViewAgent

class SelectionViewController: UIViewController {
    
    var tableView: UITableView!
    
    var tableViewAgent: UITableViewAgent!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableViewAgent = UITableViewAgent(tableView: tableView, display: UITableViewDisplay({ sections in
            sections.append(UITableViewSectionDisplay({ rows in
                
                rows.append(UITableViewRowDisplay(cellHeight: 60, cellType: AppliancesTableViewCell.self, reuseType: .nib) { tableView, indexPath, cell in
                    cell.textLabel?.text = "Traditional code style implemention"
                } didSelectRowAtIndexPath: {[weak self] tableView, indexPath, cell in
                    guard let self = self else { return }
                    let vc = TraditionalListViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                })
        
                rows.append(UITableViewRowDisplay(cellHeight: 60, cellType: UITableViewCell.self, reuseType: .anyClass) { tableView, indexPath, cell in
                    cell.textLabel?.text = "TableViewAgent code style implemention"
                } didSelectRowAtIndexPath: {[weak self] tableView, indexPath, cell in
                    guard let self = self else { return }
                    let vc = ListViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                })
            }))
        }))
        tableViewAgent.didSelectRowAtIndexPath = {[weak self] tableView, indexPath in
            guard let self = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
