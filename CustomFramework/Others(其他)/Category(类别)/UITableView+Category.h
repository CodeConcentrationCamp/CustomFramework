//
//  UITableView+Category.h
//  CustomFramework
//
//  Created by binbin on 2019/5/9.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Category)
+ (instancetype)bb_tableViewWithFrame:(CGRect)frame showHorizontalScrollIndicator:(BOOL)showHorBool showVerticalScrollIndicator:(BOOL)showVerBool withTarget:(id)target backGroundColor:(UIColor *)color andTableViewStyle:(BOOL)styleBool;
@end

NS_ASSUME_NONNULL_END
