


//
//  CFTabBarOneViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTabBarOneViewController.h"
#import "CFSingletonTool.h"
#import "CFBlockViewController.h"
@interface CFTabBarOneViewController ()
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;
@end

@implementation CFTabBarOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    [self.view addSubview:self.activityIndicator];
    //设置小菊花的frame
    self.activityIndicator.frame= CGRectMake(100, 100, 0, 0);
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor redColor];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor cyanColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
   // self.activityIndicator.hidesWhenStopped = NO;
    
    
    
    UIButton * aa = [UIButton  bb_ButtonWithFrame:CGRectMake(100, 100, 100, 20) title:@"button" image:@"11" textColor:[UIColor redColor] fontSize:20];
    [self.view addSubview:aa];
    [aa bb_handleWithBlock:^(id sender) {
        
        [self.activityIndicator startAnimating];
       // [self.activityIndicator stopAnimating];
        
    } controlEvent:UIControlEventTouchUpInside];
    
    
    UILabel * customLabel =[UILabel bb_LabelWithFrame:CGRectMake(100, 300, 200, 20) text:@"我是customLabel" textColor:[UIColor bb_gradientFromColor:[UIColor redColor] toColor:[UIColor lightGrayColor] withWidth:200] fontSize:16 textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:customLabel];
    /** 设置行间距 */
    [customLabel setColumnSpace:1];
    customLabel.userInteractionEnabled = YES;
    [customLabel bb_AddTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
       
        [self.navigationController pushViewController:[CFBlockViewController new] animated:YES];
        
    }];
    
    
    /** 单利测试 --  */
    CFSingletonTool * tool = [CFSingletonTool new];
    CFSingletonTool * tool2 = [[CFSingletonTool alloc]init];
    CFSingletonTool * tool3 = [CFSingletonTool sharedSingletonTool];
    
    NSLog(@"\n--%@\n--%@\n--%@\n",tool,tool2,tool3);
    
    
    /** 沙盒路径 */
    
    // 获取沙盒根目录路径
    NSString *homeDir = NSHomeDirectory();
    
    // 获取Documents目录路径
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject];
    
    //获取Library的目录路径
    NSString *libDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject];
    
    // 获取cache目录路径
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    
    // 获取tmp目录路径
    NSString *tmpDir =NSTemporaryDirectory();
    
    // 获取应用程序程序包中资源文件路径的方法：
    NSString *bundle = [[NSBundle mainBundle] bundlePath];
    
    NSLog(@"homeDir=%@ \n docDir=%@ \n libDir=%@ \n cachesDir=%@ \n tmpDir=%@ \n bundle=%@", homeDir,docDir, libDir, cachesDir, tmpDir, bundle);

    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
