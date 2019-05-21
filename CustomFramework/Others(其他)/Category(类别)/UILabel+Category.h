//
//  UILabel+Category.h
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Category)

/**
 快速创建label
*/
+ (instancetype)bb_LabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;


/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace;

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;

/*
 *设置字体大小
 */
- (void)settingLabelTextKitWithText:(NSString *)text withLabelFont:(UIFont *)font;

/*
 *设置字体颜色
 */
- (void)settingLabelTextColor:(UIColor *)textColor withStr:(NSString *)text;

/*
 *设置字体颜色,大小
 */
- (void)settingLabelTextKitWithText:(NSString *)text withLabelFont:(UIFont *)font withLabelTextColor:(UIColor *)textColor;

/*
 *设置字体的背景颜色
 */
- (void)settingLabelBackgroundColor:(UIColor *)backgroundColor withStr:(NSString *)text;

/*
 *设置字体的背景颜色、字体大小、选中颜色
 */
- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor;


- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor
                                    secondText:(NSString *)secondText
                                    secondFont:(UIFont *)secondFont
                               secondTextColor:(UIColor *)secondTextColor;


- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor
                                    secondText:(NSString *)secondText
                                    secondFont:(UIFont *)secondFont
                               secondTextColor:(UIColor *)secondTextColor
                         secondBackgroundColor:(UIColor *)secondBackgroundColor;

-(void)settingLabelTextColor:(UIColor*)textcolor range:(NSString*)string1 textColorTwo:(UIColor*)textcolortwo range:(NSString*)stringtwo;
-(void)settingLabelTextColor:(UIColor*)textcolor range:(NSString*)string1 textColorTwo:(UIColor*)textcolortwo range:(NSString*)stringtwo textcolorthree:(UIColor*)textcolorthree range:(NSString *)stringthree;




@end

NS_ASSUME_NONNULL_END
