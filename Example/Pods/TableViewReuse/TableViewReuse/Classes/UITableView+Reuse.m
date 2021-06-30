//
//  UITableView+Reuse.m
//  TableViewReuse
//
//  Created by bo.chen on 2021/5/28.
//

#import "UITableView+Reuse.h"


@implementation UITableView (Reuse)

/// Clean the class name's scope
- (NSString *)cleanScopeWithClassName:(NSString *)className {
    
    return ![className containsString:@"."] ? className : [className componentsSeparatedByString:@"."].lastObject;
    
}

/// Reuse cell with any class
- (id)dequeueReusableCellWithAnyClass:(Class)aClass {
    
    NSString *className = NSStringFromClass(aClass);
    id cell = [self dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[aClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
    
}

/// Reuse cell with nib class and bundle
- (id)dequeueReusableCellWithNibClass:(Class)nibClass bundle:(NSBundle *)bundle {
    
    NSString *className = NSStringFromClass(nibClass);
    id cell = [self dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        className = [self cleanScopeWithClassName:className];
        cell = ([bundle loadNibNamed:className owner:nil options:nil].firstObject);
    }
    return cell;
    
}

/// Reuse cell with nib class
- (id)dequeueReusableCellWithNibClass:(Class)nibClass {
    
    return [self dequeueReusableCellWithNibClass:nibClass bundle:NSBundle.mainBundle];
    
}

/// Reuse header or footer with nib and bundle
- (id)dequeueReusableHeaderFooterViewWithNib:(Class)nibClass bundle:(NSBundle *)bundle {
    
    NSString *className = NSStringFromClass(nibClass);
    UIView *headerFooter = [self dequeueReusableHeaderFooterViewWithIdentifier:className];
    if (!headerFooter) {
        className = [self cleanScopeWithClassName:className];
        headerFooter = [bundle loadNibNamed:className owner:nil options:nil].firstObject;
    }
    return headerFooter;
    
}

/// Reuse header or footer with nib
- (id)dequeueReusableHeaderFooterViewWithNib:(Class)nibClass {
    
    return [self dequeueReusableHeaderFooterViewWithNib:nibClass bundle:NSBundle.mainBundle];
    
}

/// Reuse cell with any class
- (id)dequeueReusableHeaderFooterViewWithAnyClass:(Class)aClass {
    
    NSString *className = NSStringFromClass(aClass);
    UIView *headerFooter = [self dequeueReusableHeaderFooterViewWithIdentifier:className];
    if (!headerFooter) {
        headerFooter = [[aClass alloc] initWithReuseIdentifier:className];
    }
    return headerFooter;
    
}

@end
