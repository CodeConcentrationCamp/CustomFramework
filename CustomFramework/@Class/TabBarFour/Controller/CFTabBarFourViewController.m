//
//  CFTabBarFourViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTabBarFourViewController.h"
#import "CFQQViewController.h"
#import "CFTableViewOneCell.h"
#import "CFBasicKnowledgeModel.h"
#import <YYModel.h>
#import "CFWebViewController.h"
#import "NSObject+Property.h"
@interface CFTabBarFourViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong) NSDictionary *dataDict;
@property (nonatomic,strong) CFBasicKnowledgeModel *cellModel ;
@end

@implementation CFTabBarFourViewController


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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"面试题";
    [self.view addSubview:self.tableView];
    NSLog(@"--%@",self.dataDict);
    
    [NSObject createPropertyCodeWithDict:[self.dataDict objectForKey:@"titleArray"][0]];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cellID";
    
    CFTableViewOneCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CFTableViewOneCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    [cell reloadCellModel:self.cellModel.titleArray[indexPath.row] cellForRowAtIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellModel.titleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CFWebViewController * webVC = [[CFWebViewController alloc]init];
    CFtitleArrayModel * model = self.cellModel.titleArray[indexPath.row];
    if (CF_StringIsEmpty(model.webUrl)) {
        return;
    }
    webVC.webUrlString = model.webUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}



- (void)navigationControllerkDetail
{
    /**
     self.title 和 self.navigationItem.title区别
     
     只要是 self.title 设置以后 -- self.navigationItem.title 设置没有任何作用
     self.navigationItem.title 设置只是单独改变本控制的title
     self.title 设置是改变本控制器的title 也改变了 tabbar 对应的title
     */
    //self.navigationItem.title = @"title";
    //  self.title = @"title";
   
    
    /**是否隐藏导航栏  */
    //self.navigationController.navigationBarHidden = YES;
    //self.navigationItem.leftBarButtonItem
    /**
     栈顶VC
     @property(nullable, nonatomic,readonly,strong) UIViewController *topViewController;
     */
   // NSLog(@"---%@",self.navigationController.topViewController);
    /**
      如果模态viewcontroller存在，返回模态viewcontroller，否则栈顶viewcontroller。
     @property(nullable, nonatomic,readonly,strong) UIViewController *visibleViewController;
      */
  //  NSLog(@"---%@",self.navigationController.visibleViewController);
    /**
      导航控制器目前栈中所管理的VC
     @property(nonatomic,copy) NSArray<__kindof UIViewController *> *viewControllers;
     */
   // NSLog(@"---%@",self.navigationController.viewControllers);
    
    
    
    
}


@end
