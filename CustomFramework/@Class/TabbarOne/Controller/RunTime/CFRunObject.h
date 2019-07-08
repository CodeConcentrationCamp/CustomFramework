//
//  CFRunObject.h
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RunBlock)(void);
@interface CFRunObject : NSObject

- (void)eat;

- (void)sleep;

@property (nonatomic,copy) RunBlock blockRun ;
@end

NS_ASSUME_NONNULL_END
