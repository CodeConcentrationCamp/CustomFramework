//
//  NSObject+RunTimeCode.m
//  CustomFramework
//
//  Created by binbin on 2019/5/27.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "NSObject+RunTimeCode.h"

@implementation NSObject (RunTimeCode)

- (void)encoder:(NSCoder *)aCoder
{
    /**  存  */
    unsigned int count = 0;
    /** 获取的是成员变量列表 -- ivars*/
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i =0; i<count; i++) {
        /** 获取列表中的每个成员变量 */
        Ivar ivar = ivars[i];
        /** 获取每个成员变量 名称name  当做Key*/
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSLog(@"--%@",key);
        id value = [self valueForKey:key];
        NSLog(@"--%@",value);
        [aCoder encodeObject:value forKey:key];
        
      }
    //在OC中使用了Copy、Creat、New类型的函数，需要释放指针！（注：ARC管不了--C函数）
    free(ivars);
}


- (void)decoder:(NSCoder *)aDecoder {
    /** 取 */
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        /** 获取Ivar的名称 */
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id value = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    free(ivars);
}
@end
