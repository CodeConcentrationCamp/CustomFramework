//
//  CFTabBarTwoViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/1/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTabBarTwoViewController.h"

#import "ORRingChartView.h"

@interface CFTabBarTwoViewController ()<ORRingChartViewDatasource> {
    NSInteger _randowValue;
}

@property (nonatomic, strong) ORRingChartView *ringView;
@property (nonatomic, strong) NSArray *graidentColors;
@property (nonatomic, strong) NSArray *graidentColor;
@end

@implementation CFTabBarTwoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _graidentColors = @[@[[UIColor redColor]],
                        @[[UIColor orangeColor]],
                        @[[UIColor yellowColor]],
                        @[[UIColor greenColor]],
                        ];
    _graidentColor= @[[UIColor redColor],
                        [UIColor orangeColor],
                        [UIColor yellowColor],
                        [UIColor greenColor]
                        ];
    _randowValue = 8;
    self.view.backgroundColor = [UIColor lightTextColor];
    
    ORRingChartView *ringView = [ORRingChartView new];
    ringView.config.neatInfoLine = NO;
    ringView.dataSource = self;
    ringView.frame = CGRectMake(0, 0, 375, 375);
    ringView.center = self.view.center;
    
    
    [self.view addSubview:ringView];
    
    self.ringView = ringView;
 
}



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.ringView.style = 3;
//    _randowValue = arc4random() % 10 + 1;
//    [self.ringView reloadData];
//}

- (NSArray<UIColor *> *)chartView:(ORRingChartView *)chartView graidentColorsAtRingIndex:(NSInteger)index {
    return self.graidentColors[index];
}


- (UIView *)viewForRingCenterOfChartView:(ORRingChartView *)chartView {
    UILabel *label = [chartView dequeueCenterView];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        label.layer.cornerRadius = 45;
        label.clipsToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textColor = [UIColor redColor];
        label.text = @"140.50";
    }
    return label;
}


- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return 4;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    
    NSArray * a = @[@(15),@(20),@(35),@(30)];
    return  [a[index] floatValue];
}

- (UIView *)chartView:(ORRingChartView *)chartView viewForTopInfoAtRingIndex:(NSInteger)index {
    UILabel *label = [UILabel new];
    label.text = [NSString stringWithFormat:@"TopIndex %zd", index];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = self.graidentColor[index];
    [label sizeToFit];
    return label;
}

- (UIView *)chartView:(ORRingChartView *)chartView viewForBottomInfoAtRingIndex:(NSInteger)index {
    UILabel *label = [chartView dequeueBottomInfoViewAtIndex:index];
    if (!label) {
        label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor =self.graidentColor[index];
    }
    label.text = [NSString stringWithFormat:@"BotIndex %zd", index];
    [label sizeToFit];
    return label;
}

//- (CGFloat)chartView:(ORRingChartView *)chartView pointWidthForInfoLineAtRingIndex:(NSInteger)index {
//
//    NSLog(@"--%ld",(long)index);
//    return 0;
//}


@end
