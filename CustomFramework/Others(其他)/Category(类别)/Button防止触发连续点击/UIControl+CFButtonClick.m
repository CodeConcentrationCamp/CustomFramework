//
//  UIControl+CFButtonClick.m
//  CustomFramework
//
//  Created by binbin on 2019/5/23.
//  Copyright © 2019 cbb. All rights reserved.
//  对单个button按钮进行操作

#import "UIControl+CFButtonClick.h"
#import <objc/runtime.h>
/** key值 */
static const char *UIControl_acceptEventInterval="UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent="UIControl_ignoreEvent";

@implementation UIControl (CFButtonClick)

#pragma mark  -- acceptEventInterval
- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval
{
     objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}


#pragma mark  -- ignoreEvent
- (void)setIgnoreEvent:(BOOL)ignoreEvent
{
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)ignoreEvent
{
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

+ (void)load
{
    Method sysMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    
    Method swizzledMethod =  class_getInstanceMethod([self class], @selector(swizzled_sendAction:to:forEvent:));
    
    
    BOOL newSys =class_addMethod([self class], @selector(sendAction:to:forEvent:), method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
    if (newSys) {
        /** 增加成功 */
        class_replaceMethod([self class], @selector(sendAction:to:forEvent:), method_getImplementation(sysMethod), method_getTypeEncoding(sysMethod));
    }else{
        method_exchangeImplementations(sysMethod, swizzledMethod);
    }
    
}

- (void)swizzled_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.ignoreEvent == YES) {
        NSLog(@"点击无效");
        return;
    }
    if (self.acceptEventInterval > 0) {
        /**  可以点击
         acceptEventInterval 时间之内只能点击一次
         */
        
        self.ignoreEvent = YES;
        [self performSelector:@selector(ignoreEventClick) withObject:self afterDelay:self.acceptEventInterval];
        
    }
    
    [self swizzled_sendAction:action to:target forEvent:event];
}

- (void)ignoreEventClick
{
    self.ignoreEvent = NO;
}

@end
