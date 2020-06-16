//
//  CFMultithreadingViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/5/9.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFMultithreadingViewController.h"

@interface CFMultithreadingViewController ()
@property (nonatomic,assign) NSInteger ticketSurplusCount;
@property (nonatomic,strong) NSThread *anhuiThread ;
@property (nonatomic,strong) NSThread *hangzhouThread ;

@property (nonatomic,strong) UIImageView *imageView ;
@end

@implementation CFMultithreadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"多线程";
    self.view.backgroundColor = [UIColor redColor];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   // [self bb_NSThread:1];
   // [self saleTicket];
    [self downLoadPicImageView];
}

#pragma mark  -- NSThread解析
/**
 NSThread是苹果官方提供面向对象操作线程的技术，简单方便，可以直接操作线程对象，不过需要自己控制线程的生命周期。在平时使用很少，最常用到的无非就是 [NSThread currentThread]获取当前线程。
 */


/** 线程之间的通信 下载图片*/
- (void)downLoadPicImageView
{
    
    [NSThread detachNewThreadWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/6a63f6246b600c3320b14bb3184c510fd8f9a185.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"下载操作所在的线程--%@",[NSThread currentThread]);
        [self performSelectorOnMainThread:@selector(reloadPic:) withObject:image waitUntilDone:YES];
    }];
}

- (void)reloadPic:(UIImage *)image
{
    self.imageView.image =image;
    NSLog(@"刷新在的线程--%@",[NSThread currentThread]);
}

/** 火车票 线程问题 --  不安全线程 加锁问题 */
- (void)saleTicket
{
    self.ticketSurplusCount = 50;
    self.anhuiThread = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    self.anhuiThread.name = @"安徽火车站售票窗口出售";
    [self.anhuiThread start];
    
    self.hangzhouThread = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
     self.hangzhouThread.name = @"杭州火车站售票窗口出售";
    [self.hangzhouThread start];
}

- (void)saleTicketNotSafe
{
    while (1) {
        
    /** 加锁处理
     加锁处理线程安全
     优点:防止多线程抢夺资源造成数据安全问题
     缺点:消耗CPU性能
     
     */
        @synchronized (self) {
        
            if (self.ticketSurplusCount > 0) {
                self.ticketSurplusCount -- ;
                
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", self.ticketSurplusCount, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];
            }else{
                NSLog(@"--票已经出售完--");
                return;
            }
        }
        
     
    }
}

/** NSThread 创建方法 */
- (void)bb_NSThread:(NSThreadStyle)style
{
    
    switch (style) {
        case 1:
        {
            /** 1.先创建线程，再启动线程 */
            NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(runThread) object:@"thread"];
            /**  线程一启动，就会在线程thread中执行self的run方法 */
            [thread start];
            
            
            /** block 方式 */
            NSThread *blockThread = [[NSThread alloc]initWithBlock:^{
                 NSLog(@"-->%@", [NSThread currentThread]);
                
            }];
            [blockThread start];
           
        }
            break;
        case 2:
        {
            /** 2.创建线程后自动启动线程 */
             [NSThread detachNewThreadSelector:@selector(runThread) toTarget:self withObject:nil];
             /** block 方式 */
            
            [NSThread detachNewThreadWithBlock:^{
                NSLog(@"-->%@", [NSThread currentThread]);
            }];
        }
            break;

        case 3:
        {
            /**  3.隐式创建并启动线程 */
            [self performSelectorInBackground:@selector(run) withObject:nil];

        }
            break;

            
        default:
            break;
    }
}

/** 新线程调用方法，里边为需要执行的任务 */
- (void)runThread {
    NSLog(@"-->%@", [NSThread currentThread]);

}

@end
