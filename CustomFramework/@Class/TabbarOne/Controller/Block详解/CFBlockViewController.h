//
//  CFBlockViewController.h
//  CustomFramework
//
//  Created by binbin on 2019/5/28.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFRootViewController.h"
typedef  void (^vcBlock) (NSString * IDString);



@interface CFBlockViewController : CFRootViewController
@property (nonatomic,copy) vcBlock blockString ;
@end


