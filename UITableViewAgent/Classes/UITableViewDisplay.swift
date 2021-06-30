//
//  UITableViewDisplay.swift
//  UITableViewAgent
//
//  Created by 陈波 on 2021/6/30.
//

import UIKit

public enum ReusableViewRegisterType {
    case anyClass
    case nib
}

public class UITableViewRowDisplay {
    
    let cellHeight:CGFloat!
    
    let autoCellHeight:Bool!
    
    var didSelectRowAtIndexPath: ((_ tableView: UITableView, _ indexPath:IndexPath) -> Void)?
    
    let cellForRowAtIndexPath: (_ tableView: UITableView, _ indexPath:IndexPath) -> UITableViewCell
    
    public init<T: UITableViewCell>(cellHeight:CGFloat, autoCellHeight:Bool, cellType: T.Type, reuseType: ReusableViewRegisterType, cellForRowAtIndexPath:@escaping (_ tableView: UITableView, _ indexPath:IndexPath, _ cell: T) -> Void) {
        self.autoCellHeight = autoCellHeight
        self.cellHeight = self.autoCellHeight == true ? UITableView.automaticDimension: cellHeight;
        self.cellForRowAtIndexPath = {tableView, indexPath in
            let cell = reuseType == .anyClass ? tableView.dequeueReusableCell(anyClass: cellType) : tableView.dequeueReusableCell(nibClass: cellType)
            cellForRowAtIndexPath(tableView, indexPath, cell)
            return cell
        }
    }
}

public class UITableViewSectionDisplay {
    
    public enum HeaderFooterReuseType<T: UIView, U: UITableViewHeaderFooterView> {
        case nibClass(_ class: T.Type, viewCallback:((_ tableView: UITableView, _ section: Int, _ header: T) -> Void))
        case anyClass(_ class: U.Type, viewCallback:((_ tableView: UITableView, _ section: Int, _ header: U) -> Void))
    }
    
    public var rows: [UITableViewRowDisplay] = []
    
    public let headerHeight: CGFloat!
    
    public let autoHeaderHeight: Bool!
    
    public var viewForHeader: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    
    public let autoFooterHeight: Bool!
    
    public let footerHeight: CGFloat!
    
    public var viewForFooter: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    
    public init<T1: UIView, T2: UIView, U1: UITableViewHeaderFooterView, U2: UITableViewHeaderFooterView>(headerHeight: CGFloat, autoHeaderHeight: Bool, headerReuse: HeaderFooterReuseType<T1, U1>?, footerHeight: CGFloat, autoFooterHeight: Bool, footerReuse: HeaderFooterReuseType<T2, U2>?, rowsCallback: (_ rows: inout Array<UITableViewRowDisplay>) -> Void) {
        self.autoHeaderHeight = autoHeaderHeight
        self.autoFooterHeight = autoFooterHeight
        self.headerHeight = self.autoHeaderHeight ? UITableView.automaticDimension : headerHeight
        self.footerHeight = self.autoFooterHeight ? UITableView.automaticDimension : footerHeight
        switch headerReuse {
        case .nibClass(let headerType, let reuseCallback):
            self.viewForHeader = {tableView, section in
                let header = tableView.dequeueReusableHeaderFooterView(nibClass: headerType)
                reuseCallback(tableView, section, header)
                return header
            }
            break
        case .anyClass(let headerType, let reuseCallback):
            self.viewForHeader = {tableView, section in
                let header = tableView.dequeueReusableHeaderFooterView(anyClass: headerType)
                reuseCallback(tableView, section, header)
                return header
            }
            break
        case .none:
            self.viewForHeader = nil
        }
        
        switch footerReuse {
        case .nibClass(let footerType, let reuseCallback):
            self.viewForFooter = {tableView, section in
                let footer = tableView.dequeueReusableHeaderFooterView(nibClass: footerType)
                reuseCallback(tableView, section, footer)
                return footer
            }
            break
        case .anyClass(let footerType, let reuseCallback):
            self.viewForFooter = {tableView, section in
                let footer = tableView.dequeueReusableHeaderFooterView(anyClass: footerType)
                reuseCallback(tableView, section, footer)
                return footer
            }
            break
        case .none:
            self.viewForFooter = nil
            
        }
        rowsCallback(&rows)
    }
}

public class UITableViewDisplay {
    
    public var sections: [UITableViewSectionDisplay] = []
    
    public init(sectionsCallback: (_ sections: inout Array<UITableViewSectionDisplay>) -> Void) {
        sectionsCallback(&sections)
    }
}
