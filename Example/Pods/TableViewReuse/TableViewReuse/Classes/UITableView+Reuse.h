//
//  UITableView+Reuse.h
//  TableViewReuse
//
//  Created by bo.chen on 2021/5/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Reuse)

/// Reuse cell with any class. (Objective-C)
- (id)dequeueReusableCellWithAnyClass:(Class)aClass;

/// Reuse cell with nib class and bundle. (Objective-C)
- (id)dequeueReusableCellWithNibClass:(Class)nibClass bundle:(NSBundle *)bundle;

/// Reuse cell with nib class. (Objective-C)
- (id)dequeueReusableCellWithNibClass:(Class)nibClass;

/// Reuse header or footer with nib and bundle. (Objective-C)
- (id)dequeueReusableHeaderFooterViewWithNib:(Class)nibClass bundle:(NSBundle *)bundle;

/// Reuse header or footer with nib. (Objective-C)
- (id)dequeueReusableHeaderFooterViewWithNib:(Class)nibClass;

/// Reuse cell with any class. (Objective-C)
- (id)dequeueReusableHeaderFooterViewWithAnyClass:(Class)aClass;


@end

NS_ASSUME_NONNULL_END
