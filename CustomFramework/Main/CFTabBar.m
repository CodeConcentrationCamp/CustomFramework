//
//  CFTabBar.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTabBar.h"
/** 判断是否是iPhone X */
#define isiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
@implementation CFTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // TabBar的尺寸
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    // 设置索引
    int index = 0;
    // 按钮的尺寸
    CGFloat tabBarButtonW = width /4;
    CGFloat tabBarButtonH = height;
    CGFloat tabBarButtonY = isiPhoneX ? -15:0;
    
    // 设置四个TabBarButton的frame
    for (UIView *tabBarButton in self.subviews) {
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        // 计算按钮的X的值
        CGFloat tabBarButtonX = index * tabBarButtonW;
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        index++;
        
    }
    for (UIImageView * imageVV in self.subviews) {
        if ([imageVV isKindOfClass:[UIImageView class]]) {
            [imageVV removeFromSuperview];
        }
    }
    
    for (UITabBarItem *item in self.items) {
        /** 齐刘海 */
        if (isiPhoneX) {
            item.titlePositionAdjustment = UIOffsetMake(0, -15);
        }
        
    }
    
}

@end
