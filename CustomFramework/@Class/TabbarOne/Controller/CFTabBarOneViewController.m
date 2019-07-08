
//
//  CFTabBarOneViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTabBarOneViewController.h"
#import "CFTableViewOneCell.h"
#import "CFBasicKnowledgeModel.h"
#import <YYModel.h>
#import "CFRunTimeDetailViewController.h"
#import "UIControl+CFButtonClick.h"
#import "CFYYModelViewController.h"
#import "CFBlockViewController.h"
#import "TableViewAnimationKit.h"
@interface CFTabBarOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong) NSDictionary *dataDict;
@property (nonatomic,strong) CFBasicKnowledgeModel *cellModel ;
@end

@implementation CFTabBarOneViewController

-(CFBasicKnowledgeModel *)cellModel
{
    return (CF_OBJECT_LAZY(_cellModel, ({
        CFBasicKnowledgeModel *cellModel = [CFBasicKnowledgeModel yy_modelWithJSON:self.dataDict];
        cellModel;
        
    })));
}

- (NSDictionary *)dataDict
{
    return (CF_OBJECT_LAZY(_dataDict, ({
        NSDictionary * data = [[ManagementTool readLocalFileWithName:@"tabbarTitle"] objectForKey:@"data"];
        NSDictionary *dataDict = [NSDictionary dictionaryWithDictionary:data];
        dataDict;
    })));
}

- (UITableView *)tableView
{
    return (CF_OBJECT_LAZY(_tableView, ({
        UITableView *tableView = [UITableView bb_tableViewWithFrame:CGRectMake(0, SafeAreaTopHeight, CF_ScreenWidth, CF_ScreenHeight -SafeAreaTopHeight - CF_tabbarHeight ) showHorizontalScrollIndicator:NO showVerticalScrollIndicator:NO withTarget:self backGroundColor:[UIColor whiteColor] andTableViewStyle:NO];
        tableView.rowHeight = 55;
        tableView.separatorStyle = UITableViewCellEditingStyleNone;
        tableView.tableHeaderView = [UIView bb_ViewWithFrame:CGRectMake(0, 0, CF_ScreenWidth, 15) backgroundColor:[UIColor whiteColor]];
        
        tableView;
    })));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    UIButton * A = [UIButton bb_ButtonWithFrame:CGRectMake(100, 100, 100, 100) title:@"点击" image:nil textColor:[UIColor redColor] fontSize:20];
    A.acceptEventInterval = 5;
    [A addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)aaa
{
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cellID";
    
     CFTableViewOneCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CFTableViewOneCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
   
    [cell reloadCellModel:self.cellModel.titleArray[indexPath.row] cellForRowAtIndexPath:indexPath];
   [TableViewAnimationKit showWithAnimationType:4 tableView:self.tableView];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellModel.titleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFtitleArrayModel * model =self.cellModel.titleArray[indexPath.row];
    UIViewController * vc =[NSClassFromString(model.vcTitle)  new];
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
