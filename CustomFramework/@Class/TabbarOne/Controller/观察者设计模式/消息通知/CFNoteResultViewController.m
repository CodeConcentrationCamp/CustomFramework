//
//  CFNoteResultViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/6/3.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFNoteResultViewController.h"

@interface CFNoteResultViewController ()

@end

@implementation CFNoteResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
     /**  发送通知 */
    [[NSNotificationCenter defaultCenter]     postNotificationName:@"notifyNameNoType" object:nil];
    [[NSNotificationCenter defaultCenter]     postNotificationName:@"notifyNameType" object:@"有数据"];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"有值" forKey:@"param"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyNameType" object:nil userInfo:dic];
}

@end
