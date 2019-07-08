//
//  CFBlockViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/5/28.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFBlockViewController.h"

@interface CFBlockViewController ()

@end

@implementation CFBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.blockString = ^(NSString *IDString) {
        NSLog(@"--%@",IDString);
    };
    /**
     
     在Block中不可以直接修改局部变量
     
     int global = 100;
     void(^fBlock)(void) = ^{
     global++; //报错 原因百度
     NSLog(@"global=%d",global);
     };
     fBlock();
     */
}

@end
