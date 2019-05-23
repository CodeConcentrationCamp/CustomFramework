//
//  CFWebViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFWebViewController.h"
#import <WebKit/WebKit.h>
@interface CFWebViewController ()<WKNavigationDelegate, WKUIDelegate>
/** webView视图 */
@property (nonatomic, strong) WKWebView *wkWebView;

/** 加载进度条 */
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation CFWebViewController


- (WKWebView *)wkWebView
{
    return (CF_OBJECT_LAZY(_wkWebView, ({
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
        wkWebView.allowsBackForwardNavigationGestures = YES;
        wkWebView.backgroundColor = [UIColor whiteColor];
        //        wkWebView.navigationDelegate = self;
        //        wkWebView.UIDelegate = self;
        //使用kvo监听进度
        [wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
        wkWebView;
    })));
}

- (UIProgressView *)progressView
{
    return (CF_OBJECT_LAZY(_progressView, ({
        UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.hidden = YES;
        //设置进度条的色彩
        [progressView setTrackTintColor: [UIColor colorWithWhite:245.0/255.0 alpha:1]];
        progressView.progressTintColor = [UIColor redColor];
        progressView;
    })));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.offset(0);
        make.top.offset(SafeAreaTopHeight);
    }];
    
    [self.view addSubview:self.progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.wkWebView);
        make.height.equalTo(@2);
    }];
    
    NSURL *url = [NSURL URLWithString:self.webUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
    self.wkWebView.navigationDelegate = self;
    

}

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

#pragma mark - navigationDelegate

/// 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // 进度条设置
    self.progressView.hidden = NO;
    self.progressView.progress = 0;
    self.progressView.alpha = 1.0;
    // 假装0.5秒后给一点进度
    [UIView animateWithDuration:0.5 animations:^{
        self.progressView.progress = 0.1;
    }];
}


// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSString *webTitle = webView.title;
    if (webTitle == nil) {
        return;
    }
    
    //禁止长按
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [UIView animateWithDuration:0.5 animations:^{
        [self.progressView setProgress:1.0 animated:YES];
    } completion:^(BOOL finished) {
        [self.progressView setAlpha:0.0];
    }];
    //[SVProgressHUD showWarningWithTitle:@"加载失败" inView:self.view];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [UIView animateWithDuration:0.5 animations:^{
        [self.progressView setProgress:1.0 animated:YES];
    } completion:^(BOOL finished) {
        [self.progressView setAlpha:0.0];
    }];
    //  [SVProgressHUD showWarningWithTitle:@"加载失败" inView:self.view];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //[self performSelector:@selector(delayLoadNavRight) withObject:nil afterDelay:0.5];
    
}


#pragma mark - kvo 监听网页加载进度
//keyPath:属性名称
//object:被观察的对象
//change:变化前后的值都存储在change字典中
//context:注册观察者的时候,context传递过来的值
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView ) {
        [self.progressView setAlpha:1.0];

        if (CF_StringIsEmpty(self.wkWebView.title)) {
            self.title =@"加载中...";
        }else{
            self.title = self.wkWebView.title;
        }
        
        self.title = self.wkWebView.title;
        
        if (self.wkWebView.estimatedProgress >= 1.0) {
            [UIView animateWithDuration:1.0 animations:^{
                [self.progressView setProgress:1.0 animated:YES];
            } completion:^(BOOL finished) {
                [self.progressView setAlpha:0.0];
            }];
            
        } else {
            [self.progressView setProgress:self.wkWebView.estimatedProgress ];
            [self.progressView setAlpha:1.0];
        }
    }
}




@end
