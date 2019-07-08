//
//  CFDataPersistenceModel.h
//  CustomFramework
//
//  Created by binbin on 2019/5/27.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFDataPersistenceModel : NSObject<NSSecureCoding>
@property (nonatomic,copy) NSString *name ;
@property (nonatomic,copy) NSString *age ;
@property (nonatomic,copy) NSString *sex ;
@property (nonatomic,copy) NSString *IDCard ;
@end

NS_ASSUME_NONNULL_END
