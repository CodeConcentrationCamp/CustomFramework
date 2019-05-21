//
//  CFTabBarController.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTabBarController.h"

#import "CFTabBarOneViewController.h"
#import "CFTabBarTwoViewController.h"
#import "CFTabBarThreeViewController.h"
#import "CFTabBarFourViewController.h"
#import "CFNavigationController.h"
#import "CFTabBar.h"
#import "CFTabBarModel.h"

@interface CFTabBarController ()

@property (nonatomic, copy) NSArray *itemsModel;

@end

@implementation CFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildViewController];
    [self setUpTabBar];
    
}

- (void)setUpTabBar
{
    [self setValue:[[CFTabBar alloc] init] forKey:@"tabBar"];
}


/**
 设置 ChildViewController
 */
- (void)setUpChildViewController
{
    CFTabBarModel * tabBarOneModel = [CFTabBarModel createTabbarModel:@"CFTabBarOneViewController" title:@"首页" image:@"Tabbar_act" imageSelected:@"Tabbar_act_selected"];
    CFTabBarModel * tabBarTwoModel = [CFTabBarModel createTabbarModel:@"CFTabBarTwoViewController" title:@"活动" image:@"Tabbar_home" imageSelected:@"Tabbar_home_selected"];
    CFTabBarModel * tabBarThreeModel = [CFTabBarModel createTabbarModel:@"CFTabBarThreeViewController" title:@"动画" image:@"Tabbar_act" imageSelected:@"Tabbar_act_selected"];
    CFTabBarModel * tabBarFourModel = [CFTabBarModel createTabbarModel:@"CFTabBarFourViewController" title:@"我的" image:@"Tabbar_mine" imageSelected:@"Tabbar_mine_selected"];
    self.itemsModel = @[tabBarOneModel,tabBarTwoModel,tabBarThreeModel,tabBarFourModel];
    
 
    
    for (CFTabBarModel * model in self.itemsModel) {
        Class viewController = NSClassFromString(model.viewController);
        UIViewController *childVC = [[viewController alloc] init];
        childVC.tabBarItem.title = model.title;
        
        /**
         typedef NS_ENUM(NSInteger, UIImageRenderingMode) {
         UIImageRenderingModeAutomatic,     默认  -- 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
         UIImageRenderingModeAlwaysOriginal,     -- 始终绘制图片原始状态，不使用Tint Color
         UIImageRenderingModeAlwaysTemplate,     -- 始终根据Tint Color绘制图片，忽略图片的颜色信息。
         } NS_ENUM_AVAILABLE_IOS(7_0);
         */
        
        childVC.tabBarItem.image = [[UIImage imageNamed:model.image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childVC.tabBarItem.selectedImage = [[UIImage imageNamed:model.imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
      
        
        if ([model.viewController isEqualToString:@"CFTabBarOneViewController"]) {
            childVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@", @"4"];
            childVC.tabBarItem.badgeColor = [UIColor redColor];
        }else{
            /**设置角标 富文本 */
            [childVC.tabBarItem setBadgeTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
            childVC.tabBarItem.badgeValue = @"●";
            childVC.tabBarItem.badgeColor = [UIColor clearColor];
        }
        
        CFNavigationController *nav = [[CFNavigationController alloc] initWithRootViewController:childVC];
        [self addChildViewController:nav];
    }

}



@end
