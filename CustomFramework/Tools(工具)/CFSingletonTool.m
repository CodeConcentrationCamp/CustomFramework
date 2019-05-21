//
//  CFSingletonTool.m
//  CustomFramework
//
//  Created by binbin on 2019/2/25.
//  Copyright © 2019 cbb. All rights reserved.
//  单例模式的讲解

#import "CFSingletonTool.h"

@interface CFSingletonTool ()<NSCopying>

@end

@implementation CFSingletonTool

static CFSingletonTool * _singletonTool = nil;

/**
  单利模式 -- 在程序运行的过程中 一个类只有一个实例
 
-- 用例 --
 网络请求 登录控制器
-- 系统原生用例 --
 UIApplication(应用程序实例类)
 NSNotificationCenter(消息中心类)
 NSFileManager(文件管理类)
 NSUserDefaults(应用程序设置)
 NSURLCache(请求缓存类)
 NSHTTPCookieStorage(应用程序cookies池)
 
 
 优点
 1.节约系统资源，提高程序运行率
 2.灵活，一个单例可以在多个类中共同使用
 
 缺点
 1.无法继承没有子类
 2.没有类的扩展
 3.创建后 对象指针保存在 静态区域 单利在堆中分配内存空间会在程序终止时候才会释放
 
 注意使用单利之前  一定要考虑单例类是否适合类以后的扩展，避免盲目使用单例。。
 
 */


+ (instancetype)sharedSingletonTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singletonTool = [CFSingletonTool new];
    });
    return  _singletonTool;
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

/** 3.使用同步锁保证init 创建唯一单利 -- 和once的效果相同 */
- (instancetype)init
{
    @synchronized (self) {
        self = [super init];
    }
    return self;
}

@end
