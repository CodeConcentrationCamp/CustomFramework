//
//  CFRunObject.m
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFRunObject.h"
#import <objc/runtime.h>
@implementation CFRunObject

void dynamicMethodIMP(id self, SEL _cmd) {
    NSLog(@"--SLEEP--");
}
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == NSSelectorFromString(@"sleep")) {
        
        return class_addMethod(self, sel, (IMP)dynamicMethodIMP, "@V:");
    }
    
    return  [super resolveInstanceMethod:sel];
}

- (void)eat
{
    CFLog(@"--runEat--");
}
@end
