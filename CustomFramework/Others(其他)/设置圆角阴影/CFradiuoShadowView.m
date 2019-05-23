//
//  CFradiuoShadowView.m
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFradiuoShadowView.h"

@interface CFradiuoShadowView ()

/** 什么是 CALayer ？？？？*/
@property (nonatomic,strong) CALayer *subLayer ;

@end

@implementation CFradiuoShadowView

- (void)bb_addOffsetWithCornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)shadowColor {
    if (!_subLayer) {
        _subLayer = [CALayer layer];
        CGRect fixframe = self.frame;
        _subLayer.frame = fixframe;
        _subLayer.cornerRadius = cornerRadius;
        _subLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _subLayer.masksToBounds = NO;
        _subLayer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
        _subLayer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        _subLayer.shadowOpacity = 0.5;//阴影透明度，默认0
        _subLayer.shadowRadius = 5;//阴影半径，默认3
        [self.superview.layer insertSublayer:_subLayer below:self.layer];
    }
}

@end
