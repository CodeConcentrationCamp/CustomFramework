//
//  CFSingletonTool.h
//  CustomFramework
//
//  Created by binbin on 2019/2/25.
//  Copyright © 2019 cbb. All rights reserved.
//  单利的创建

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFSingletonTool : NSObject

+ (instancetype)sharedSingletonTool;
@end

NS_ASSUME_NONNULL_END
