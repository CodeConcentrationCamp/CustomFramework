
//
//  CFTableViewOneCell.m
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTableViewOneCell.h"
#import "CFradiuoShadowView.h"
#import "CFBasicKnowledgeModel.h"
@interface CFTableViewOneCell ()

@property (nonatomic,strong) CFradiuoShadowView *bgView ;
@property (nonatomic,strong) UILabel *labelText;
@end


@implementation CFTableViewOneCell

- (UILabel *)labelText
{
    return (CF_OBJECT_LAZY(_labelText, ({
        UILabel *labelText = [UILabel bb_LabelWithFrame:CGRectZero text:@"**" textColor:[UIColor blackColor] fontSize:15 textAlignment:NSTextAlignmentLeft];
        labelText;
    })));
}

- (CFradiuoShadowView *)bgView
{    return (CF_OBJECT_LAZY(_bgView, ({
        CFradiuoShadowView *bgView =[[CFradiuoShadowView alloc]initWithFrame:CGRectMake(15, 5, CF_ScreenWidth - 30, 45)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView;
    })));
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp_UI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUp_UI
{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.labelText];
    [self.labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.centerY.equalTo(self.bgView.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
     [self.bgView bb_addOffsetWithCornerRadius:8 shadowColor:[UIColor lightGrayColor]];
}

- (void)reloadCellModel:(CFtitleArrayModel *)cellModel cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   self.labelText.text =cellModel.title;
}
@end
