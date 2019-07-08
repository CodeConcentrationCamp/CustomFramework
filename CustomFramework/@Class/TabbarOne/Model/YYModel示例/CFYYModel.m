//
//  CFYYModel.m
//  CustomFramework
//
//  Created by binbin on 2019/5/28.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFYYModel.h"

@implementation CFYYModel


+ (NSDictionary * )modelCustomPropertyMapper
{
   // return @{@"personId":@"id"};
    // 映射可以设定多个映射字段
    return @{@"personId":@[@"id",@"uid",@"ID"],
             @"sex":@"sexDic.sex" ,
             @"work":@"job.work",
             @"eveDay":@"job.eveDay",
             @"site":@"job.site"
             };
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{@"eats" : [YYEatModel class]};
}

@end

@implementation YYEatModel


@end
