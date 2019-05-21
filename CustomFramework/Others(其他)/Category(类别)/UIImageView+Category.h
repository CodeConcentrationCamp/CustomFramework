//
//  UIImageView+Category.h
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Category)

+ (instancetype)bb_ImageViewWithFrame:(CGRect)frame imageViewPic:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
