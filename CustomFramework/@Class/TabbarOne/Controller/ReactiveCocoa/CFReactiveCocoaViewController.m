//
//  CFReactiveCocoaViewController.m
//  CustomFramework
//
//  Created by bitcoke on 2020/6/28.
//  Copyright © 2020 cbb. All rights reserved.
//

#import "CFReactiveCocoaViewController.h"

@interface CFReactiveCocoaViewController ()<UITextFieldDelegate>

@end

@implementation CFReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * racButton = [UIButton  bb_ButtonWithFrame:CGRectMake(10, SafeAreaTopHeight + 20, 50, 50) title:@"racButton" image:@"" textColor:[UIColor redColor] fontSize:16];
    [self.view addSubview:racButton];
    [[racButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        NSLog(@"racButton");
    }];
    
    UITextField * textFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(racButton.frame        )+ 20, 100, 20)];
    textFiled.delegate = self;
    [self.view addSubview:textFiled];
    
//    [[textFiled rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(id x) {
//        RACTupleUnpack(UITextField * te) = x;
//            NSLog(@"---%@",te.text);
//    }];
    
   
    [[textFiled rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x) {
        
    }];
    
 
}


@end
