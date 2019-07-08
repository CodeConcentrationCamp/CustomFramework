//
//  CFCustomChartView.m
//  CustomFramework
//
//  Created by binbin on 2019/7/1.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFCustomChartView.h"

static CGRect myFrame;

@implementation CFCustomChartView

 + (instancetype)initWithFrame:(CGRect)frame
{
    CFCustomChartView *chartView =[[CFCustomChartView alloc]initWithFrame:frame];
    
    UIView * bgView = [UIView bb_ViewWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) backgroundColor:[UIColor clearColor]];
    [chartView addSubview:bgView];
    
    myFrame = frame;
    return chartView;
}

#pragma mark ------ 绘制饼状图 -------

/**
 *  画饼状图
 */
- (void)drawPieChartViewWithType_Names:(NSMutableArray *)type_names TargetValues:(NSMutableArray *)targetValues {
    
    // 设置圆点
    CGPoint point = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat startAngle = 0;
    CGFloat endAngle;
    CGFloat radius = 70;
    
    // 计算总数
    __block CGFloat allValue = 0;
    [targetValues enumerateObjectsUsingBlock:^(NSNumber *targetNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        allValue += [targetNumber floatValue];
    }];
    
    NSArray *redArray = @[@"46",@"255",@"62",@"254",@"253",@"153",@"110", @"173",@"223",@"196"];
    NSArray *greenArray = @[@"191",@"48",@"209",@"199",@"109",@"208",@"123", @"110",@"142",@"193"];
    NSArray *blueArray = @[@"238",@"145",@"185",@"17",@"31",@"60",@"254", @"157",@"36",@"48"];
    
    // 画图
    for (int i =0; i<targetValues.count; i++) {
        
        CGFloat targetValue = [targetValues[i] floatValue];
        endAngle = startAngle + targetValue/allValue*2*M_PI;
        
        // bezierPath形成闭合的扇形路径
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:point
                                                                  radius:radius
                                                              startAngle:startAngle                                                                 endAngle:endAngle
                                                               clockwise:YES];
        [bezierPath addLineToPoint:point];
        [bezierPath closePath];
        
        // 填充色
        UIColor *customColor = [UIColor colorWithRed:[[redArray objectAtIndex:i] intValue]/255.0  green:[[greenArray objectAtIndex:i] intValue]/255.0 blue:[[blueArray objectAtIndex:i] intValue]/255.0 alpha:1];
        
        // 渲染
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.lineWidth = 1;
        // 填充色
        shapeLayer.fillColor = customColor.CGColor;
        shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:shapeLayer];
        
        // 饼图引出点
        CGFloat pieX = point.x + (radius)*cos(startAngle+(endAngle-startAngle)/2);
        CGFloat pieY = point.y + (radius)*sin(startAngle+(endAngle-startAngle)/2);
        
        // 指引线引出点
        CGFloat X = point.x + (radius+20)*cos(startAngle+(endAngle-startAngle)/2);
        CGFloat Y = point.y + (radius+20)*sin(startAngle+(endAngle-startAngle)/2);
        CGFloat lineWidth = 80;
        
        // 绘制小圆点
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.frame = CGRectMake(0, 0, 1, 1); // 指定frame，只是为了设置宽度和高度
        circleLayer.position = CGPointMake(X, Y); // 设置居中显示
        circleLayer.fillColor = [UIColor clearColor].CGColor; // 设置填充颜色
        circleLayer.lineWidth = 2.0;
        circleLayer.strokeColor = customColor.CGColor;
        // 使用UIBezierPath创建路径
        CGRect frame = CGRectMake(0, 0, 2, 2);
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
        // 设置CAShapeLayer与UIBezierPath关联
        circleLayer.path = circlePath.CGPath;
        // 将CAShaperLayer放到某个层上显示
        [self.layer addSublayer:circleLayer];
        
        // 画第一段直线
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.frame = CGRectMake(0, 0, 1, 1); // 指定frame，只是为了设置宽度和高度
        lineLayer.fillColor = [UIColor clearColor].CGColor; // 设置填充颜色
        lineLayer.lineWidth = 1.0;
        lineLayer.strokeColor = customColor.CGColor;
        UIBezierPath *indicatrixLine = [UIBezierPath bezierPath];
        [indicatrixLine moveToPoint:CGPointMake(pieX, pieY)];
        [indicatrixLine addLineToPoint:CGPointMake(X, Y)];
        lineLayer.path = indicatrixLine.CGPath;
        lineLayer.lineWidth = 1.0;
        lineLayer.strokeColor = customColor.CGColor;
        [self.layer addSublayer:lineLayer];
        
        if (X < point.x) { // 饼图左侧
            X = X - lineWidth;
        }
        // 添加指引线(第二段直线)
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(X, Y, lineWidth, 1)];
        line.backgroundColor = customColor;
        [self.subviews[0] addSubview:line];
        
        // 添加文字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(X, Y - 15, lineWidth, 30)];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = customColor;
        label.numberOfLines = 0;
        label.text = type_names[i];
        label.attributedText = [self setupAttriLabelWithTitleStr:type_names[i] ValueStr:[NSString stringWithFormat:@"%@", targetValues[i]]];
        [self.subviews[0] addSubview:label];
        if (X < point.x) { // 饼图左侧
            label.textAlignment = NSTextAlignmentLeft;
        } else {
            label.textAlignment = NSTextAlignmentRight;
        }
        
        startAngle = endAngle;
    }
    
    // 画一个圆, 用来空心(如果满圆则可以不要这块)
    UIBezierPath *radiusPath = [UIBezierPath bezierPathWithArcCenter:point radius:radius * 0.3 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [radiusPath addLineToPoint:point];
    [radiusPath closePath];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.path = radiusPath.CGPath;
    [self.layer addSublayer:shapeLayer];
}

/**
 * label 的富文本布局
 *
 * titleStr 标题
 * ValueStr 值
 */
- (NSMutableAttributedString *)setupAttriLabelWithTitleStr:(NSString *)titleStr ValueStr:(NSString *)valueStr {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@", titleStr, valueStr]];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(titleStr.length+1, valueStr.length)];
    //    [string addAttribute:NSForegroundColorAttributeName value:ZLWhiteTitleColor range:NSMakeRange(titleStr.length+1, valueStr.length)];
    
    return string;
}

///**
// *  画饼状图
// */
//- (void)drawPieChartViewWithType_Names:(NSMutableArray *)type_names TargetValues:(NSMutableArray *)targetValues {
//
//    // 设置圆点
//    CGPoint point = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
//    CGFloat startAngle = 0;
//    CGFloat endAngle;
//    CGFloat radius = 70;
//
//    // 计算总数
//    __block CGFloat allValue = 0;
//    [targetValues enumerateObjectsUsingBlock:^(NSNumber *targetNumber, NSUInteger idx, BOOL * _Nonnull stop) {
//        allValue += [targetNumber floatValue];
//    }];
//
//    NSArray *redArray = @[@"46",@"255",@"62",@"254",@"253",@"153",@"110"];
//    NSArray *greenArray = @[@"191",@"48",@"209",@"199",@"109",@"208",@"123"];
//    NSArray *blueArray = @[@"238",@"145",@"185",@"17",@"31",@"60",@"254"];
//
//    // 画图
//    for (int i =0; i<targetValues.count; i++) {
//
//        CGFloat targetValue = [targetValues[i] floatValue];
//        endAngle = startAngle + targetValue/allValue*2*M_PI;
//
//        // bezierPath形成闭合的扇形路径
//        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:point
//                                                                  radius:radius
//                                                              startAngle:startAngle                                                                 endAngle:endAngle
//                                                               clockwise:YES];
//        [bezierPath addLineToPoint:point];
//        [bezierPath closePath];
//
//        // 填充色
//        UIColor *customColor = [UIColor colorWithRed:[[redArray objectAtIndex:i] intValue]/255.0  green:[[greenArray objectAtIndex:i] intValue]/255.0 blue:[[blueArray objectAtIndex:i] intValue]/255.0 alpha:1];
//
//        // 渲染
//        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//        shapeLayer.lineWidth = 1;
//        // 填充色
//        shapeLayer.fillColor = customColor.CGColor;
//        shapeLayer.path = bezierPath.CGPath;
//        [self.layer addSublayer:shapeLayer];
//
//        // 饼图引出点
//        CGFloat pieX = point.x + (radius)*cos(startAngle+(endAngle-startAngle)/2);
//        CGFloat pieY = point.y + (radius)*sin(startAngle+(endAngle-startAngle)/2);
//        // 指示线第一段(小段) 计算起点
//        if (pieX < point.x) { // 左侧
//
//            pieX = pieX - 10;
//
//            if (pieY < point.y) {
//                pieY = pieY - 10;
//            } else {
//                pieY = pieY + 10;
//            }
//        } else { // 右侧
//
//            pieX = pieX + 10;
//            if (pieY < point.y) { // 上侧
//
//                pieY = pieY - 10;
//            } else { // 下侧
//
//                pieY = pieY + 10;
//            }
//        }
//        // 绘制小圆点
//        CAShapeLayer *circleLayer = [CAShapeLayer layer];
//        circleLayer.frame = CGRectMake(0, 0, 1, 1); // 指定frame，只是为了设置宽度和高度
//        circleLayer.position = CGPointMake(pieX, pieY); // 设置居中显示
//        circleLayer.fillColor = [UIColor clearColor].CGColor; // 设置填充颜色
//        circleLayer.lineWidth = 2.0;
//        circleLayer.strokeColor = customColor.CGColor;
//        // 使用UIBezierPath创建路径
//        CGRect frame = CGRectMake(0, 0, 2, 2);
//        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
//        // 设置CAShapeLayer与UIBezierPath关联
//        circleLayer.path = circlePath.CGPath;
//        // 将CAShaperLayer放到某个层上显示
//        [self.layer addSublayer:circleLayer];
//
//        // 指引线引出点
//        CGFloat X = point.x + (radius+20)*cos(startAngle+(endAngle-startAngle)/2);
//        CGFloat Y = point.y + (radius+20)*sin(startAngle+(endAngle-startAngle)/2);
//        CGFloat lineWidth = 80;
//
//        // 指示线第一段(小段) 计算终点
//        if (X < point.x) { // 左侧
//
//            X = X - 10;
//
//            if (Y < point.y) {
//                Y = Y - 10;
//            } else {
//                Y = Y + 10;
//            }
//        } else { // 右侧
//
//            X = X + 10;
//            if (Y < point.y) { // 上侧
//
//                Y = Y - 10;
//            } else { // 下侧
//
//                Y = Y + 10;
//            }
//        }
//        // 画第一段直线
//        CAShapeLayer *lineLayer = [CAShapeLayer layer];
//        lineLayer.frame = CGRectMake(0, 0, 1, 1); // 指定frame，只是为了设置宽度和高度
//        lineLayer.fillColor = [UIColor clearColor].CGColor; // 设置填充颜色
//        lineLayer.lineWidth = 1.0;
//        lineLayer.strokeColor = customColor.CGColor;
//        UIBezierPath *indicatrixLine = [UIBezierPath bezierPath];
//        [indicatrixLine moveToPoint:CGPointMake(pieX, pieY)];
//        [indicatrixLine addLineToPoint:CGPointMake(X, Y)];
//        lineLayer.path = indicatrixLine.CGPath;
//        lineLayer.lineWidth = 1.0;
//        lineLayer.strokeColor = customColor.CGColor;
//        [self.layer addSublayer:lineLayer];
//
//        if (X < point.x) { // 饼图左侧
//            X = X - lineWidth;
//        }
//
//        // 添加指引线(第二段直线)
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(X, Y, lineWidth, 1)];
//        line.backgroundColor = customColor;
//        [self.subviews[0] addSubview:line];
//
//        // 添加文字
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(X, Y - 15, lineWidth, 30)];
//        label.font = [UIFont systemFontOfSize:12];
//        label.textColor = customColor;
//        label.numberOfLines = 0;
//        label.text = type_names[i];
//        label.attributedText = [self setupAttriLabelWithTitleStr:type_names[i] ValueStr:[NSString stringWithFormat:@"%@", targetValues[i]]];
//        [self.subviews[0] addSubview:label];
//        if (X < point.x) { // 饼图左侧
//            label.textAlignment = NSTextAlignmentLeft;
//        } else {
//            label.textAlignment = NSTextAlignmentRight;
//        }
//
//        startAngle = endAngle;
//    }
//
//    // 画一个圆, 用来空心(如果满圆则可以不要这块)
//    UIBezierPath *radiusPath = [UIBezierPath bezierPathWithArcCenter:point radius:radius * 0.3 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [radiusPath addLineToPoint:point];
//    [radiusPath closePath];
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.lineWidth = 1;
//    shapeLayer.fillColor = ZLBackgroundColor.CGColor;
//    shapeLayer.path = radiusPath.CGPath;
//    [self.layer addSublayer:shapeLayer];
//}


@end
