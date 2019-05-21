//
//  CFTabBarModel.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTabBarModel.h"

@implementation CFTabBarModel

+ (CFTabBarModel *)createTabbarModel:(NSString *)viewController title:(NSString *)title image:(NSString *)image imageSelected:(NSString *)imageSelected
{
    CFTabBarModel * model =[[CFTabBarModel alloc]init];
    model.title          = title;
    model.viewController = viewController;
    model.image          = image;
    model.imageSelected  = imageSelected;
    return model;
}

@end
