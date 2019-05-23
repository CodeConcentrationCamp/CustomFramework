//
//  CFBasicKnowledgeModel.h
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CFtitleArrayModel;
NS_ASSUME_NONNULL_BEGIN

@interface CFBasicKnowledgeModel : NSObject
@property (nonatomic, strong) NSMutableArray<CFtitleArrayModel *> *titleArray;
@end

@interface CFtitleArrayModel : NSObject
@property (nonatomic,copy) NSString *title ;
@property (nonatomic,copy) NSString *upTime ;
@property (nonatomic,copy) NSString *witerTime ;
@property (nonatomic,copy) NSString *webUrl ;
@end



NS_ASSUME_NONNULL_END
