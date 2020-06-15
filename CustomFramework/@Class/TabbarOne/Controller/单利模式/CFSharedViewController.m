//
//  CFSharedViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/6/4.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFSharedViewController.h"

@interface CFSharedViewController ()

@end

@implementation CFSharedViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ManagementTool *t1 = [[ManagementTool alloc]init];
    ManagementTool *t2 = [[ManagementTool alloc]init];
    ManagementTool *t3 = [ManagementTool new];
    ManagementTool *t4 = [ManagementTool sharedInstance];
    ManagementTool *t5 = [t1 copy];
    ManagementTool *t6 = [t1 mutableCopy];

    NSLog(@"t1:%p\n t2:%p\n t3:%p\n t4:%p\n t5:%p\n t6:%p",t1,t2,t3,t4,t5,t6);
}



@end
