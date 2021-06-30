//
//  UITableViewAgent.swift
//  UITableViewAgent
//
//  Created by 陈波 on 2021/6/30.
//

import UIKit
import TableViewReuse

open class UITableViewAgent: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    open var display: UITableViewDisplay!
    
    open var didSelectRowAtIndexPath: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?
    
    public init(tableView: UITableView, display: UITableViewDisplay) {
        super.init()
        self.display = display
        tableView.delegate = self
        tableView.dataSource = self
    }

    open func numberOfSections(in tableView: UITableView) -> Int {
        return display.sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return display.sections[section].rows.count
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return display.sections[section].headerHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return display.sections[section].headerHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return display.sections[section].footerHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return display.sections[section].headerHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return display.sections[indexPath.section].rows[indexPath.row].cellHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return display.sections[indexPath.section].rows[indexPath.row].cellHeight
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionDisplay = self.display.sections[section]
        if sectionDisplay.viewForHeader != nil {
            return sectionDisplay.viewForHeader!(tableView, section)
        }
        return nil
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionDisplay = self.display.sections[section]
        if sectionDisplay.viewForFooter != nil {
            return sectionDisplay.viewForFooter!(tableView, section)
        }
        return nil
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionDisplay = self.display.sections[indexPath.section]
        let rowDisplay = sectionDisplay.rows[indexPath.row]
        return rowDisplay.cellForRowAtIndexPath(tableView, indexPath)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionDisplay = self.display.sections[indexPath.section]
        let rowDisplay = sectionDisplay.rows[indexPath.row]
        if self.didSelectRowAtIndexPath != nil {
            self.didSelectRowAtIndexPath!(tableView, indexPath)
        }
        if rowDisplay.didSelectRowAtIndexPath != nil {
            rowDisplay.didSelectRowAtIndexPath!(tableView, indexPath)
        }
    }
}

