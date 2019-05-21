//
//  CFNavigationController.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFNavigationController.h"

@interface CFNavigationController ()

@end

@implementation CFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self hiddenNavgationBarLineImgViewWithTranslucent:NO];
}


// 去掉navigationBar 系统底部横线。 再配合 self.navigationBar.translucent = YES;，导航栏就会透明
- (void)hiddenNavgationBarLineImgViewWithTranslucent:(BOOL)translucent
{
    if (translucent) {
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
        
        return;
    }
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromHex(0x252525),
                                                 NSFontAttributeName: [UIFont fontWithName:@"PingFangTC-Semibold" size:18]}];
    [self.navigationBar setShadowImage:[UIImage new]];
    self.navigationBar.barTintColor = [UIColor whiteColor];
}


- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
/**
 重写导航控制器的push方法®
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    //控制器跳转的时候隐藏tabBar
    NSLog(@"--%@",self.navigationController.viewControllers);
    if (self.viewControllers.count > 0) {
        // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
}




@end
