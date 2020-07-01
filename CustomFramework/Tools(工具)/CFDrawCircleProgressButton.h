//
//  CFDrawCircleProgressButton.h
//  CustomFramework
//
//  Created by bitcoke on 2020/6/29.
//  Copyright © 2020 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DrawCircleProgressBlock)(void);
@interface CFDrawCircleProgressButton : UIButton
@property (nonatomic, strong) UIColor    *trackColor;
@property (nonatomic, strong) UIColor    *progressColor;
@property (nonatomic, strong) UIColor    *fillColor;
@property (nonatomic, assign) CGFloat    lineWidth;
@property (nonatomic, assign) CGFloat    animationDuration;
- (void)startAnimationDuration:(CGFloat)duration withBlock:(DrawCircleProgressBlock )block;

@end
