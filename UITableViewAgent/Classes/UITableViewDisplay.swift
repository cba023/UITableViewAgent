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
    
    let cellHeight:CGFloat
    
    let autoCellHeight:Bool
    
    let didSelectRowAtIndexPath: (_ tableView: UITableView, _ indexPath: IndexPath) -> Void
    
    let cellForRowAtIndexPath: (_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell
    
    public init<T: UITableViewCell>(cellHeight:CGFloat, autoCellHeight: Bool = false, cellType: T.Type, reuseType: ReusableViewRegisterType, _ cellForRowAtIndexPath:@escaping (_ tableView: UITableView, _ indexPath:IndexPath, _ cell: T) -> Void, didSelectRowAtIndexPath: ((_ tableView: UITableView, _ indexPath:IndexPath, _ cell: T) -> Void)? = nil) {
        self.autoCellHeight = autoCellHeight
        self.cellHeight = self.autoCellHeight == true ? UITableView.automaticDimension: cellHeight;
        self.cellForRowAtIndexPath = {tableView, indexPath in
            let cell = reuseType == .anyClass ? tableView.dequeueReusableCell(anyClass: cellType) : tableView.dequeueReusableCell(nibClass: cellType)
            cellForRowAtIndexPath(tableView, indexPath, cell)
            return cell
        }
        self.didSelectRowAtIndexPath = {tableView, indexPath in
            let cell = tableView.cellForRow(at: indexPath) as! T
            didSelectRowAtIndexPath?(tableView, indexPath, cell)
        }
    }
}

public class UITableViewSectionDisplay {
    
    public enum HeaderFooterReuseType<T: UIView, U: UITableViewHeaderFooterView> {
        case nibClass(_ class: T.Type, _ viewCallback:((_ tableView: UITableView, _ section: Int, _ reusableHeaderFooterView: T) -> Void))
        case anyClass(_ class: U.Type, _ viewCallback:((_ tableView: UITableView, _ section: Int, _ reusableHeaderFooterView: U) -> Void))
    }
    
    public var rows: [UITableViewRowDisplay] = []
    
    public let headerHeight: CGFloat
    
    public let autoHeaderHeight: Bool
    
    public var viewForHeader: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    
    public let autoFooterHeight: Bool
    
    public let footerHeight: CGFloat
    
    public var viewForFooter: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    
    public init<T1: UIView, T2: UIView, U1: UITableViewHeaderFooterView, U2: UITableViewHeaderFooterView>(headerHeight: CGFloat = CGFloat.leastNormalMagnitude, autoHeaderHeight: Bool = false, headerReuse: HeaderFooterReuseType<T1, U1>? = nil, footerHeight: CGFloat = CGFloat.leastNormalMagnitude, autoFooterHeight: Bool = false, footerReuse: HeaderFooterReuseType<T2, U2>? = nil, _ rowsCallback: (_ rows: inout Array<UITableViewRowDisplay>) -> Void) {
        self.autoHeaderHeight = autoHeaderHeight
        self.autoFooterHeight = autoFooterHeight
        self.headerHeight = self.autoHeaderHeight ? UITableView.automaticDimension : headerHeight
        self.footerHeight = self.autoFooterHeight ? UITableView.automaticDimension : footerHeight
        
        switch headerReuse {
        case let .nibClass(headerType, reuseCallback):
            self.viewForHeader = {tableView, section in
                let header = tableView.dequeueReusableHeaderFooterView(nibClass: headerType)
                reuseCallback(tableView, section, header)
                return header
            }
            break
        case let .anyClass(headerType, reuseCallback):
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
        case let .nibClass(footerType, reuseCallback):
            self.viewForFooter = {tableView, section in
                let footer = tableView.dequeueReusableHeaderFooterView(nibClass: footerType)
                reuseCallback(tableView, section, footer)
                return footer
            }
            break
        case let .anyClass(footerType, reuseCallback):
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
    
    public init(_ sectionsCallback: (_ sections: inout Array<UITableViewSectionDisplay>) -> Void) {
        sectionsCallback(&sections)
    }
}
