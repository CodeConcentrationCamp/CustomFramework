//
//  CFradiuoShadowView.h
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFradiuoShadowView : UIView
- (void)bb_addOffsetWithCornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)shadowColor;
@end

NS_ASSUME_NONNULL_END
