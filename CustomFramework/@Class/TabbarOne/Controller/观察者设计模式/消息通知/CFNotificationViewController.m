//
//  CFNotificationViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/6/3.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFNotificationViewController.h"
#import "CFNoteResultViewController.h"
@interface CFNotificationViewController ()

@end

@implementation CFNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
   [self setUp_notification];
}

- (void)setUp_notification
{
    /** 1.不传递参数, 最常用的一种 */
    /** 注册通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiNoType) name:@"notifyNameNoType" object:nil];

    /** 2.使用object 传递消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiType:) name:@"notifyNameType" object:nil];
}

- (void)notiNoType
{
    NSLog(@"-- -- 没有参数 -- -- ");
}

- (void)notiType:(NSNotification *)noti
{
    /**
     @property (nullable, readonly, retain) id object;
     @property (nullable, readonly, copy) NSDictionary *userInfo;
     */
    if ([noti.name isEqualToString:@"notifyNameNoType"]) {
        
        NSString *info = [noti object];
        
        NSLog(@"接收 object传递的消息：%@",info);
        
        NSLog(@"--%@",noti.userInfo);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CFNoteResultViewController * vc =[CFNoteResultViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc {
    // 移除观察者。
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"notifyNameNoType"
                                                  object:nil];
    NSLog(@"移除");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
