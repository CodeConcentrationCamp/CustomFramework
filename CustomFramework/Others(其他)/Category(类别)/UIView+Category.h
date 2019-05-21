//
//  UIView+Category.h
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^TapActionBlock)(UITapGestureRecognizer *gestureRecoginzer) ;

@interface UIView (Category)

/** x*/
@property (nonatomic, assign) CGFloat x;
/** y*/
@property (nonatomic, assign) CGFloat y;
/** 宽度*/
@property (nonatomic, assign) CGFloat width;
/** 高度*/
@property (nonatomic, assign) CGFloat height;
/** 尺寸*/
@property (nonatomic, assign) CGSize  size;
/** centerX*/
@property (nonatomic, assign) CGFloat centerX;
/** centerY*/
@property (nonatomic, assign) CGFloat centerY;


/**
 快速创建View
 */

+ (instancetype)bb_ViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

/**
 给View 增加 手势
 */


- (void)bb_AddTapActionWithBlock:(TapActionBlock)block;


/*
 * 给UIView 设置圆角
 */
@property (assign,nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign,nonatomic) IBInspectable BOOL  masksToBounds;

/*
 * 设置 view的 边框颜色(选择器和Hex颜色)
 * 以及 边框的宽度
 */
@property (assign,nonatomic) IBInspectable NSInteger borderWidth;
/**
 borderHexRgb 颜色 字符串
 */
@property (strong,nonatomic) IBInspectable NSString  *borderHexRgb;
/**
 borderColor 颜色 正常
 */
@property (strong,nonatomic) IBInspectable UIColor   *borderColor;


@end

NS_ASSUME_NONNULL_END
