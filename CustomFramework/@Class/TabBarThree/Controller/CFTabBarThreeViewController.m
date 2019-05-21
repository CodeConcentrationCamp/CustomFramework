//
//  CFTabBarThreeViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTabBarThreeViewController.h"
#import "CFMultithreadingViewController.h"
@interface CFTabBarThreeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView ;
@end

@implementation CFTabBarThreeViewController

-(UITableView *)tableView
{
    return (CF_OBJECT_LAZY(_tableView, ({
        UITableView *tableView = [UITableView bb_tableViewWithFrame:CGRectMake(0, SafeAreaTopHeight, CF_ScreenWidth, CF_ScreenHeight - SafeAreaTopHeight -CF_tabbarHeight ) showHorizontalScrollIndicator:NO showVerticalScrollIndicator:NO withTarget:self backGroundColor:[UIColor whiteColor] andTableViewStyle:NO];
        tableView.rowHeight = 50;
        tableView;
    })));
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
   // self.tableView.tableFooterView = [UIView bb_ViewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellID =@"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text =@"多线程";
    cell.textLabel.textColor = [UIColor redColor];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFMultithreadingViewController * vc = [CFMultithreadingViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
