//
//  NSObject+CFLog.m
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "NSObject+CFLog.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (CFLog)
//
//+ (NSString *)myLog
//{
//    NSString * AA =[NSString stringWithFormat:@"%s:  (%@方法) 第%d行: \n\n",[[ManagementTool getCurrentDate] UTF8String] ,NSStringFromSelector(_cmd),__LINE__];
//    
//    return AA;
//}

//+ (void)load
//{
//    Method description = class_getClassMethod(self,
//                                              @selector(description));
//
//    Method myLog = class_getClassMethod(self, @selector(myLog));
//                
//    method_exchangeImplementations(description, myLog);
//}


@end
