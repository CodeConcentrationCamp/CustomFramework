//
//  NSObject+Model.m
//  CustomFramework
//
//  Created by binbin on 2019/5/27.
//  Copyright © 2019 cbb. All rights reserved.
//  简单 的 字典转模型

#import "NSObject+Model.h"
#import <objc/runtime.h>
@implementation NSObject (Model)

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    
    id objc = [[self alloc] init];

    unsigned int count = 0;
  
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        /** 获取一个成员变量的数组 */
        Ivar ivar = ivars[i];
        /** 获取Ivar的名称 */
        NSString * ivarnName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        /** 获取key */
        NSString * key = [ivarnName substringFromIndex:1];
        
        id value = dict[key];
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

@end
