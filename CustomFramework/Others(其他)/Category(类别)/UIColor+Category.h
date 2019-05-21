//
//  UIColor+Category.h
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 颜色  默认的颜色就是常用的*/
#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Category)

/**
  渐变颜色  从上到下
 */
+ (UIColor*)bb_gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(CGFloat)height;
/**
  渐变颜色  从左到右
 */
+ (UIColor*)bb_gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withWidth:(int)width;
/**
  颜色转图片
 */
+ (UIImage*)createImageWithColor:(UIColor*) color;
@end

NS_ASSUME_NONNULL_END
