//
//  TableViewAnimationKit.h
//  CustomFramework
//
//  Created by binbin on 2019/7/1.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BBTableViewAnimationType){
    BBTableViewAnimationTypeMove = 0,
    BBTableViewAnimationTypeAlpha,
    BBTableViewAnimationTypeFall,
    BBTableViewAnimationTypeShake,
    BBTableViewAnimationTypeOverTurn,
    BBTableViewAnimationTypeToTop,
    BBTableViewAnimationTypeSpringList,
    BBTableViewAnimationTypeShrinkToTop,
    BBTableViewAnimationTypeLayDown,
    BBTableViewAnimationTypeRote,
};

@interface TableViewAnimationKit : NSObject
+ (void)showWithAnimationType:(BBTableViewAnimationType)animationType tableView:(UITableView *)tableView;

+ (void)moveAnimationWithTableView:(UITableView *)tableView;
+ (void)alphaAnimationWithTableView:(UITableView *)tableView;
+ (void)fallAnimationWithTableView:(UITableView *)tableView;
+ (void)shakeAnimationWithTableView:(UITableView *)tableView;
+ (void)overTurnAnimationWithTableView:(UITableView *)tableView;
+ (void)toTopAnimationWithTableView:(UITableView *)tableView;
+ (void)springListAnimationWithTableView:(UITableView *)tableView;
+ (void)shrinkToTopAnimationWithTableView:(UITableView *)tableView;
+ (void)layDownAnimationWithTableView:(UITableView *)tableView;
+ (void)roteAnimationWithTableView:(UITableView *)tableView;
@end

