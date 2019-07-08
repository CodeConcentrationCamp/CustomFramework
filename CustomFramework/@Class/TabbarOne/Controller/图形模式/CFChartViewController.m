//
//  CFChartViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/7/1.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFChartViewController.h"
#import "CFCustomChartView.h"
#import "CFTriangleView.h"
@interface CFChartViewController ()
// 饼图相关
@property (strong, nonatomic) CFCustomChartView *pieChartView;
@property (strong, nonatomic) NSMutableArray *type_names; // 类型名称
@property (strong, nonatomic) NSMutableArray *type_values; // 数据值
@end

@implementation CFChartViewController
#pragma mark - 懒加载

// 饼图类型名称
- (NSMutableArray *)type_names {
    if (!_type_names) {
        _type_names = [NSMutableArray array];
        _type_names = [NSMutableArray arrayWithArray:@[@"主粮系列",@"零食世界",@"益智玩具",@"衣服狗窝",@"保健医用",@"活体",@"日用系列"]];
    }
    return _type_names;
}

// 饼图类型数据
- (NSMutableArray *)type_values {
    if (!_type_values) {
        _type_values = [NSMutableArray array];
        _type_values = [NSMutableArray arrayWithArray:@[@"100",@"100",@"100",@"200",@"200",@"100",@"200"]];
        
    }
    return _type_values;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 饼图画布初始化
//    _pieChartView = [CFCustomChartView initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 250)];
//    _pieChartView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_pieChartView];
//    // 饼图
//    [_pieChartView drawPieChartViewWithType_Names:self.type_names TargetValues:self.type_values];
    
   // [self drawTrianglePath];
    
    CFTriangleView * triangleView = [[CFTriangleView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:triangleView];
    triangleView.backgroundColor =[UIColor cyanColor];
    
    
}




@end
