//
//  ManagementTool.h
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagementTool : NSObject<NSCopying, NSMutableCopying>

/** 单利 */
+ (instancetype)sharedInstance;


/** 读取本地JSON文件 name-文件名称.前面*/
+ (NSDictionary *)readLocalFileWithName:(NSString *)name;



/** 获取当前的时间 */
+ (NSString *)getCurrentDate;
@end

NS_ASSUME_NONNULL_END
