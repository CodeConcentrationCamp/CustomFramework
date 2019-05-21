//
//  UITableView+Category.m
//  CustomFramework
//
//  Created by binbin on 2019/5/9.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "UITableView+Category.h"

@implementation UITableView (Category)
+ (instancetype)bb_tableViewWithFrame:(CGRect)frame showHorizontalScrollIndicator:(BOOL)showHorBool showVerticalScrollIndicator:(BOOL)showVerBool withTarget:(id)target backGroundColor:(UIColor *)color andTableViewStyle:(BOOL)styleBool
{
    UITableViewStyle tableViewStyle;
    tableViewStyle = (styleBool == YES)  ?  UITableViewStyleGrouped:UITableViewStylePlain;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:tableViewStyle];
    tableView.showsVerticalScrollIndicator = showVerBool;
    tableView.showsHorizontalScrollIndicator = showHorBool;
    tableView.delegate =target;
    tableView.dataSource =target;
    tableView.backgroundColor = color;
    return tableView;
}
@end
