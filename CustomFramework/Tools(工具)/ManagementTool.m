//
//  ManagementTool.m
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "ManagementTool.h"



@implementation ManagementTool

/**
 什么是单利 --  运用了gcd创建  ？？ 什么是GCD --- 什么是多线程
 
 优点:
 保证系统中该类有且仅有一个实例,便于外界访问
 节省系统资源
 缺点:单例实例一旦创建,对象指针是保存在静态区的,那么在堆区分配空间只有在应用程序终止后才会被释放
 单例不能继承,不利于扩展

 */

static ManagementTool * __singleton__;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        __singleton__ = [super allocWithZone:zone];
    });
    return __singleton__;
    
}

+ (instancetype)sharedInstance
{
    return [[self alloc]init];
}

- (id)copyWithZone:(NSZone *)zone
{
    return __singleton__;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return __singleton__;
}


/** 读取本地JSON文件 */
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}




#pragma mark  --- iOS 获取相关时间
/** 获取当前的时间 */
+ (NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}


@end
