//
//  CFStartPageView.m
//  CustomFramework
//
//  Created by bitcoke on 2020/6/29.
//  Copyright © 2020 cbb. All rights reserved.
//

#import "CFStartPageView.h"
#import "CFDrawCircleProgressButton.h"
#import "CFWebViewController.h"
@interface CFStartPageView ()

// 启动页图
@property (nonatomic,strong) UIImageView *imageView;

// 跳过按钮
@property (nonatomic, strong) CFDrawCircleProgressButton *drawCircleBtn;

@end

// 倒计时时间
static int const showtime = 3;

@implementation CFStartPageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 1.启动页图片
        _imageView = [[UIImageView alloc]initWithFrame:frame];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = [UIImage imageNamed:@"1"];
        [self addSubview:_imageView];
        
        // 2.跳过按钮
        CFDrawCircleProgressButton *drawCircleBtn = [[CFDrawCircleProgressButton alloc]initWithFrame:CGRectMake(CF_ScreenWidth - 55, 30, 40, 40)];
        drawCircleBtn.lineWidth = 2;
        [drawCircleBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [drawCircleBtn setTitleColor:[UIColor  colorWithRed:197/255.0 green:159/255.0 blue:82/255.0 alpha:1] forState:UIControlStateNormal];
        drawCircleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [drawCircleBtn bb_handleWithBlock:^(id sender) {
            CFWebViewController * webVC = [[CFWebViewController alloc]init];
            webVC.webUrlString = @"https://www.jianshu.com/p/12f1cd30f190";
            [[CFRootViewController getCurrentVC].navigationController pushViewController:webVC animated:YES];
        } controlEvent:UIControlEventTouchUpInside];
        [drawCircleBtn addTarget:self action:@selector(removeProgress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:drawCircleBtn];
        self.drawCircleBtn = drawCircleBtn;
        
    }
    return self;
}
- (void)show {

    //  progress 完成时候的回调
    __weak __typeof(self) weakSelf = self;
    [weakSelf.drawCircleBtn startAnimationDuration:showtime withBlock:^{
        [weakSelf removeProgress];
    }];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
// 移除启动页面
- (void)removeProgress {
    
    self.imageView.transform = CGAffineTransformMakeScale(1, 1);
    self.imageView.alpha = 1;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.drawCircleBtn.hidden = NO;
        self.imageView.alpha = 0;
        //self.imageView.transform = CGAffineTransformMakeScale(5, 5);
    } completion:^(BOOL finished) {
        self.drawCircleBtn.hidden = YES;
        [self.imageView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
@end
