//
//  CFTabBarModel.h
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFTabBarModel : NSObject

@property (nonatomic, copy) NSString *viewController;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *imageSelected;

+ (CFTabBarModel *)createTabbarModel:(NSString *)viewController
                               title:(NSString *)title
                               image:(NSString *)image
                       imageSelected:(NSString *)imageSelected;

@end

NS_ASSUME_NONNULL_END
