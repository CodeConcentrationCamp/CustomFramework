//
//  CFRootViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//
/**左导航栏按钮*/
#define kLEFT_NAVBAR (@"left_navbar_item")
/**右导航栏按钮*/
#define kRIGHT_NAVBAR (@"right_navbar_item")
#import "CFRootViewController.h"

@interface CFRootViewController ()

@end

@implementation CFRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setUpBackButton];
    
}

#pragma mark   返回按钮
- (void)setUpBackButton
{
    NSLog(@"---%@",self.navigationController.viewControllers);
    if (self.navigationController  &&  self.navigationController.viewControllers.count >1 ) {
        /** 证明是二级子界面 */
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClicked)];
        [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
    }
}

- (void)backItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addBarItem:(NSString *)title withBackgroundImage:(NSString *)backgroundImage withDirection:(NSString *)direction {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 15)];
    if (title != nil) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    if (backgroundImage != nil) {
        [btn setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if ([direction isEqualToString:kLEFT_NAVBAR]) {
        [btn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = barItem;
    } else if ([direction isEqualToString:kRIGHT_NAVBAR]) {
        [btn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = barItem;
    }
}

- (void)leftClick:(UIButton *)btn {
    NSLog(@"子类需要重写%s", __FUNCTION__);
}
- (void)rightClick:(UIButton *)btn {
    NSLog(@"子类需要重写%s", __FUNCTION__);
}




@end
