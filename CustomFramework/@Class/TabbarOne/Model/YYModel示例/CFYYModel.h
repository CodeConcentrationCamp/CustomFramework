//
//  CFYYModel.h
//  CustomFramework
//
//  Created by binbin on 2019/5/28.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YYEatModel;
NS_ASSUME_NONNULL_BEGIN

@interface CFYYModel : NSObject

@property (copy,   nonatomic) NSString *name;
@property (assign, nonatomic) int age;
@property (copy,   nonatomic) NSString *sex;

@property (strong, nonatomic) NSNumber *personId;

@property (strong, nonatomic) NSArray *languages;
//@property (strong, nonatomic) NSDictionary *job;
@property (copy,   nonatomic) NSString *work;
@property (copy,   nonatomic) NSString *eveDay;
@property (copy,   nonatomic) NSString *site;

@property (nonatomic,strong) NSArray <YYEatModel *> *eats ;
@end

@interface YYEatModel : NSObject

@property (copy, nonatomic)NSString *food;
@property (copy, nonatomic)NSString *date;

@end

NS_ASSUME_NONNULL_END
