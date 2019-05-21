//
//  UIButton+Category.h
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, BBButtonEdgeInsetsStyle) {
    BBButtonEdgeInsetsStyleTop,     // image在上
    BBButtonEdgeInsetsStyleLeft,    // image在左
    BBButtonEdgeInsetsStyleBottom,  // image在下
    BBButtonEdgeInsetsStyleRight    // image在右
};

typedef void (^BBButtonActionBlock)(id sender);
@interface UIButton (CLCategory)

/**
 快速创建Button
 */
+(id)bb_ButtonWithFrame:(CGRect)frame
                  title:(NSString *)title
                  image:(NSString *)image
              textColor:(UIColor *)textColor
               fontSize:(CGFloat)fontSize;



/**
  处理事件
 */
- (void)bb_handleWithBlock:(BBButtonActionBlock)actionBlock controlEvent:(UIControlEvents)controlEvent;


/**
 *  扩大 UIButton 的点击范围
 *  上下左右需要延伸的范围
 *
 *  @param top    上
 *  @param right  右
 *  @param bottom 下
 *  @param left   左
 */
- (void)bb_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;


/**
 位置处理
 */
- (void)bb_LayoutButtonWithEdgeInsetsStyle:(BBButtonEdgeInsetsStyle)style
                           imageTitleSpace:(CGFloat)space;

/** 摇晃 */
- (void)bb_ButtonShake;


//开启UIButton防连点模式
+ (void)enableInsensitiveTouch;
//关闭UIButton防连点模式
+ (void)disableInsensitiveTouch;
//设置防连续点击最小时间差(s),不设置则默认值是0.5s
+ (void)setInsensitiveMinTimeInterval:(NSTimeInterval)interval;




/**
 设置按钮背景色是渐变的
 
 @param fromColor 开始颜色
 @param toColor 结束颜色
 */
- (void)bb_setGradientBackgroundImage:(UIColor *)fromColor toColor:(UIColor *)toColor;

/**
 设置按钮背景是纯色的
 
 @param color 颜色
 */
- (void)bb_setBackgroundImageWithColor:(UIColor *)color;

@end
