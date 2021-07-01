//
//  TraditionalListViewController.swift
//  UITableViewAgent_Example
//
//  Created by bo.chen on 2021/7/1.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

// 使用传统UITableViewDataSource和UITableViewDelegate代理方式实现TableView定制展示，
// 缺点：代码量大，可阅读性差，灵活性不足

import UIKit


class TraditionalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var appliances: AppliancesModel!
    
    var news: NewsModel!
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    
    func setupData() {
        self.appliances = Util.getDataSource(from: "Appliances", fileType: "json", type: AppliancesModel.self)
        self.news = Util.getDataSource(from: "NewsList", fileType: "json", type: NewsModel.self)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        tableView = UITableView(frame: .init(origin: .zero, size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height)), style: .grouped)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.news.newslist?.count ?? 0
        } else if section == 1 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else if indexPath.section == 1 {
            return 80.0
        } else {
            return 100.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 45.0
        } else if section == 1 {
            return 90.0
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50.0
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(nibClass: NewsListTableHeaderView.self)
            header.lblName.text = "新闻列表"
            return header
        } else if section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(nibClass: AppliancesTableHeaderView.self)
            header.lblName.text = self.appliances.name
            return header
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footer = tableView.dequeueReusableHeaderFooterView(nibClass: NewsListTableFooterView.self)
            footer.lblDesc.text = "上面是新闻"
            return footer
        } else {
            return UIView()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(nibClass: NewsListTableViewCell.self)
            cell.lblTitle.text = self.news.newslist![indexPath.row].title
            cell.lblSubTitle.text = self.news.newslist![indexPath.row].source
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(nibClass: AppliancesTableViewCell.self)
            // dequeueReusableCell(withIdentifier: "AppliancesTableViewCell", for: indexPath) as! AppliancesTableViewCell
            cell.lblName.text = self.appliances!.name
            cell.lblColor.text = self.appliances!.color
            cell.lblPrice.text = "\(self.appliances!.price)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(anyClass: PersonTCell.self)
            cell.lblName.text = "人物 - \(indexPath.row)"
            return cell
        }
    }
    
}
