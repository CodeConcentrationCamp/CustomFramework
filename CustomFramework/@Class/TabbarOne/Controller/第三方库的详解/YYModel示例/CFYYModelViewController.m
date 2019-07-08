//
//  CFYYModelViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/5/28.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFYYModelViewController.h"
#import "NSObject+Property.h"
#import "CFYYModel.h"
#import <YYModel.h>
@interface CFYYModelViewController ()

@end

@implementation CFYYModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    /** 1.字典转模型 */
    NSDictionary *dic = @{
                          @"name":@"张三",
                          @"age":@(12),
                          @"sex":@"男"
                          };
    
   CFYYModel * model = [CFYYModel yy_modelWithDictionary:dic];
   CFLog(@"--%@",model);
   NSDictionary * modelDic = [model yy_modelToJSONObject];
   CFLog(@"--%@",modelDic);
    
   /** 2.自定义属性映射数据交换 */
    NSDictionary *dic2 = @{
                          @"id":@"123",
                          @"name":@"张三",
                          @"age":@(12),
                          @"sex":@"男"
                          };
    CFYYModel * model2 = [CFYYModel yy_modelWithDictionary:dic2];
    CFLog(@"--%@",model2.personId);
    NSDictionary * modelDic2 = [model2 yy_modelToJSONObject];
    CFLog(@"--%@",modelDic2);

    /** 3.多样化的数据类型交换 */

    NSDictionary *dic3 = @{
                          @"id":@"123",
                          @"name":@"张三",
                          @"age":@(12),
                          @"sexDic":@{@"sex":@"男"},
                          @"languages":@[
                                  @"汉语",@"英语",@"法语"
                                  ],
                          @"job":@{
                                  @"work":@"iOS开发",
                                  @"eveDay":@"10小时",
                                  @"site":@"软件园"
                                  }
                          };
    CFYYModel * model3 = [CFYYModel yy_modelWithDictionary:dic3];
    CFLog(@"--%@",model3.work);
    
    /** 4.自定义类数据转换 */
    NSDictionary *dic4 = @{
                          @"id":@"123",
                          @"name":@"张三",
                          @"age":@(12),
                          @"sexDic":@{@"sex":@"男"},
                          @"languages":@[
                                  @"汉语",@"英语",@"法语"
                                  ],
                          @"job":@{
                                  @"work":@"iOS开发",
                                  @"eveDay":@"10小时",
                                  @"site":@"软件园"
                                  },
                          @"eats":@[
                                  @{@"food":@"西瓜",@"date":@"8点"},
                                  @{@"food":@"烤鸭",@"date":@"14点"},
                                  @{@"food":@"西餐",@"date":@"20点"}
                                  ]
                          };
    CFYYModel *model4 = [CFYYModel yy_modelWithDictionary:dic4];
    for (YYEatModel *eat in model4.eats) {
        CFLog(@"%@",eat.food);
    }
    
    /** 5.YYModel数据的其他处理
     
     在转化过程中，YYModel提供了过滤的功能，可以将想要转换的属性或者不需要转换的属性加入到黑白名单中，通常不同时使用。
     
     
     // 黑白名单不同时使用
     // 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
     + (NSArray *)modelPropertyBlacklist {
     return @[@"sex", @"languages"];
     }
     // 如果实现了该方法，则处理过程中不会处理该列表外的属性。
     + (NSArray *)modelPropertyWhitelist {
     return @[@"eats"];
     }
     */
    
    /** 6.处理
     
   
     // 当 JSON 转为 Model 完成后，该方法会被调用。
     - (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
     // 可以在这里处理一些数据逻辑，如NSDate格式的转换
     return YES;
     }
     
     // 当 Model 转为 JSON 完成后，该方法会被调用。
     - (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
     return YES;
     }
     
     */

}


@end
