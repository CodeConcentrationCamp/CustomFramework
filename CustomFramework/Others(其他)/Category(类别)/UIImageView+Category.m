//
//  UIImageView+Category.m
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)

+ (instancetype)bb_ImageViewWithFrame:(CGRect)frame imageViewPic:(NSString *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

@end
