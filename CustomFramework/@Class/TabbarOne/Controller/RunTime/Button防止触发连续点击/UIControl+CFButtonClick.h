//
//  UIControl+CFButtonClick.h
//  CustomFramework
//
//  Created by binbin on 2019/5/23.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (CFButtonClick)

/** 延迟的时间 */
@property (nonatomic,assign) NSTimeInterval  acceptEventInterval ;
/**  */
@property (nonatomic)  BOOL ignoreEvent ;

@end

NS_ASSUME_NONNULL_END
