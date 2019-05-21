//
//  CFTabBarFourViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTabBarFourViewController.h"
#import "CFQQViewController.h"
@interface CFTabBarFourViewController ()

@end

@implementation CFTabBarFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self navigationControllerkDetail];
}


- (void)navigationControllerkDetail
{
    /**
     self.title 和 self.navigationItem.title区别
     
     只要是 self.title 设置以后 -- self.navigationItem.title 设置没有任何作用
     self.navigationItem.title 设置只是单独改变本控制的title
     self.title 设置是改变本控制器的title 也改变了 tabbar 对应的title
     */
    //self.navigationItem.title = @"title";
    //  self.title = @"title";
   
    
    /**是否隐藏导航栏  */
    //self.navigationController.navigationBarHidden = YES;
    //self.navigationItem.leftBarButtonItem
    /**
     栈顶VC
     @property(nullable, nonatomic,readonly,strong) UIViewController *topViewController;
     */
   // NSLog(@"---%@",self.navigationController.topViewController);
    /**
      如果模态viewcontroller存在，返回模态viewcontroller，否则栈顶viewcontroller。
     @property(nullable, nonatomic,readonly,strong) UIViewController *visibleViewController;
      */
  //  NSLog(@"---%@",self.navigationController.visibleViewController);
    /**
      导航控制器目前栈中所管理的VC
     @property(nonatomic,copy) NSArray<__kindof UIViewController *> *viewControllers;
     */
   // NSLog(@"---%@",self.navigationController.viewControllers);
    
    
    
    
}


@end
