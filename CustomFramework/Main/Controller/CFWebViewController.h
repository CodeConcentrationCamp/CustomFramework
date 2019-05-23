//
//  CFWebViewController.h
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFWebViewController : CFRootViewController
/** webView 的url */
@property (nonatomic, copy) NSString *webUrlString;
@end

NS_ASSUME_NONNULL_END
