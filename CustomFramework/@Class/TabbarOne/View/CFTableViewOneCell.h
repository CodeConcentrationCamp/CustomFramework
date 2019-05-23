//
//  CFTableViewOneCell.h
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFtitleArrayModel;
NS_ASSUME_NONNULL_BEGIN

@interface CFTableViewOneCell : UITableViewCell
- (void)reloadCellModel:(CFtitleArrayModel *)cellModel cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
