//
//  CFSingletonTool.m
//  CustomFramework
//
//  Created by binbin on 2019/2/25.
//  Copyright © 2019 cbb. All rights reserved.
//  单例模式的讲解

#import "CFSingletonTool.h"

@interface CFSingletonTool ()<NSCopying,NSMutableCopying>

@end

@implementation CFSingletonTool

static CFSingletonTool * _singletonTool = nil;



+ (instancetype)sharedSingletonTool
{
    return [[self alloc]init];
}

/** 避免发生的意外  --处理-- */

/** 1.防止使用alloc 开辟空间 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!_singletonTool) {

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _singletonTool = [super allocWithZone:zone ];
        });
    }
    return _singletonTool;
}

/** 2.防止copy */
- (nonnull id)copyWithZone:(nullable NSZone *)zone
{
    return _singletonTool;
}


- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _singletonTool;
}

/** 使用GCD 不用 3.使用同步锁保证init 创建唯一单利 -- 和once的效果相同 */
//- (instancetype)init
//{
//    @synchronized (self) {
//        self = [super init];
//    }
//    return self;
//}

@end
