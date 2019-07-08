//
//  NSObject+RunTimeCode.h
//  CustomFramework
//
//  Created by binbin on 2019/5/27.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RunTimeCode)
- (void)encoder:(NSCoder *)aCoder;
- (void)decoder:(NSCoder *)aDecoder;
@end

NS_ASSUME_NONNULL_END
