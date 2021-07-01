//
//  ListViewModel.swift
//  TableViewAgent_Example
//
//  Created by bo.chen on 2021/6/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

// 使用TableViewAgent方式实现TableView定制展示
// 优点：代码量小，可阅读性好，灵活性强
// 注意：由于使用了闭包，要避免因循环引用而导致内存泄漏

import UIKit
import UITableViewAgent

class ListViewModel {
    
    var appliances: Box<AppliancesModel?> = Box(nil)
    var news: Box<NewsModel?> = Box(nil)
    let tableView: UITableView
    var tableViewAgent: UITableViewAgent!
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.appliances.value = Util.getDataSource(from: "Appliances", fileType: "json", type: AppliancesModel.self)
        self.news.value = Util.getDataSource(from: "NewsList", fileType: "json", type: NewsModel.self)
    }
    
    func display() {
        let display = UITableViewDisplay({ (sections) in
            // 1.News
            sections.append(UITableViewSectionDisplay(headerHeight: 45.0, autoHeaderHeight: false, headerReuse:.nibClass(NewsListTableHeaderView.self, { tabelView, section, header in
                header.lblName.text = "新闻列表"
            }), footerHeight: 50.0, autoFooterHeight: false, footerReuse: .nibClass(NewsListTableFooterView.self, { tableView, section, footer in
                footer.lblDesc.text = "上面是新闻"
            }), { rows in
                for (_, value) in (self.news.value?.newslist!.enumerated())! {
                    let row = UITableViewRowDisplay(cellHeight: 60.0, autoCellHeight: true, cellType: NewsListTableViewCell.self, reuseType: .nib) { tableView, indexPath, cell in
                        cell.lblTitle.text = value.title
                        cell.lblSubTitle.text = value.source
                    }
                    rows.append(row)
                }
            }))

            // 2.Appliances
            sections.append(UITableViewSectionDisplay(headerHeight: 90.0, autoHeaderHeight: false, headerReuse:.nibClass(AppliancesTableHeaderView.self, {[weak self] tableView, section, header in
                guard let self = self else { return }
                header.lblName.text = self.appliances.value?.name
            }), footerHeight: CGFloat.leastNormalMagnitude, autoFooterHeight: false, footerReuse: .none, { rows in
                rows.append(UITableViewRowDisplay(cellHeight: 100.0, autoCellHeight: false, cellType: AppliancesTableViewCell.self, reuseType: .nib, {[weak self] tableView, indexPath, cell in
                    guard let self = self else { return }
                    cell.lblName.text = self.appliances.value?.name
                    cell.lblColor.text = self.appliances.value?.color
                    cell.lblPrice.text = "\(self.appliances.value!.price)"
                }))
            }))

            // 3. Animal & Person
            sections.append(UITableViewSectionDisplay(headerHeight: CGFloat.leastNormalMagnitude, autoHeaderHeight: false, headerReuse: .none, footerHeight: CGFloat.leastNormalMagnitude, autoFooterHeight: false, footerReuse: .none, { rows in
                for i in 0..<10 {
                    rows.append(UITableViewRowDisplay(cellHeight: 80.0, autoCellHeight: false, cellType: PersonTCell.self, reuseType: .anyClass, { tableView, indexPath, cell in
                        cell.lblName.text = "人物 - \(i)"
                    }))
                }
            }))
        })
        self.tableViewAgent = UITableViewAgent(tableView: tableView, display: display)
        self.tableViewAgent.didSelectRowAtIndexPath = {(tableView, indexPath)
            in
            tableView.deselectRow(at: indexPath, animated: true)
        }
        self.tableView.reloadData()
    }
    
    deinit {
        print("✅✅✅✅")
    }
    
    
}
