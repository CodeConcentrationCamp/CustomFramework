//
//  CFBlockViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/2/26.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFBlockViewController.h"

typedef void(^nameBlock)(void);

@interface CFBlockViewController ()
@property (nonatomic,copy) nameBlock blockName ;
@end

@implementation CFBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /** Block 的理解以及使用 */
    self.blockName = ^{
        NSLog(@"---Block---");
    };
    self.blockName();
    
    
    /**
     1.block  为什么 要用copy修饰
     block -- 创建的时候默认分配在栈中 随时会被系统回收 copy 将其拷贝到堆内存中
     
     2.为什么进入Blockd中的对象引用计数需要自动+1
     Block执行的是回调  因此Block并不知道其中的对象obj创建后会在什么时候释放 为了不在Block使用obj之前，对象已经被释放，Block就retain了obj一次
     
     */
    
}




@end
