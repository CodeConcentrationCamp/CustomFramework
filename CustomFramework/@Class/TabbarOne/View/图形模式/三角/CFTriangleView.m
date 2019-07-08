//
//  CFTriangleView.m
//  CustomFramework
//
//  Created by binbin on 2019/7/1.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFTriangleView.h"
//#define RadianToDegrees(radian) (radian*180.0)/(M_PI)
#define DegreesToRadian(x) (M_PI * (x) / 180.0)
@implementation CFTriangleView

 - (void)drawRect:(CGRect)rect
{
    [self drawTrianglePath:rect];
}

/** 画圆 */
- (void)drawYuanRect:(CGRect)rect {
    
    UIColor *color = [UIColor redColor];
    [color set];
    /*
     ArcCenter: 原点
     radius: 半径
     startAngle: 开始角度
     endAngle: 结束角度
     clockwise: 是否顺时针方向
     */
   
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100,200) radius:45 startAngle:DegreesToRadian(0) endAngle:DegreesToRadian(120) clockwise:YES];
  
    [path stroke];
    
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.path = path.CGPath;
   circleLayer.lineWidth = 2.f;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
   circleLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:circleLayer];
    
    
    circleLayer.strokeStart = 0.f;
    circleLayer.strokeEnd = 0.f;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 3.f;   // 持续时间
    animation.fromValue = @(0); // 从 0 开始
    animation.toValue = @(1);   // 到 1 结束
    // 保持动画结束时的状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // 动画缓慢的进入，中间加速，然后减速的到达目的地。
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [circleLayer addAnimation:animation forKey:@""];
}



/** 三角形 */
- (void)drawTrianglePath:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(rect.size.width - 100, 0)];
    [path addLineToPoint:CGPointMake(rect.size.width - 100, rect.size.height- 100)];
    [path addLineToPoint:CGPointMake(0, rect.size.height- 100)];
   [path closePath];
    
    /** 设置线头样式 */
    /**
     1、kCGLineCapButt 该属性值指定不绘制端点， 线条结尾处直接结束。这是默认值。
     2、kCGLineCapRound 该属性值指定绘制圆形端点， 线条结尾处绘制一个直径为线条宽度的半圆。
     3、kCGLineCapSquare 该属性值指定绘制方形端点。 线条结尾处绘制半个边长为线条宽度的正方形。需要说明的是，这种形状的端点与“butt”形状的端点十分相似，只是采用这种形式的端点的线条略长一点而已
     */
    path.lineCapStyle =kCGLineCapRound;
    
    path.lineJoinStyle = kCGLineJoinRound;
    /**
     4、path.lineJoinStyle这个属性是用来设置两条线连结点的样式，同样它也有三种样式供我们选择
     (
     1、kCGLineJoinMiter 斜接
     2、kCGLineJoinRound 圆滑衔接
     3、kCGLineJoinBevel 斜角连接
     ）
     */
    
    // 设置线宽
    path.lineWidth = 3;
    
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    /** 填充 */
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor cyanColor];
    [strokeColor set];
    
    // 根据我们设置的各个点连线
    [path stroke];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.path = path.CGPath;
    circleLayer.lineWidth = 2.f;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:circleLayer];
    
    
    circleLayer.strokeStart = 0.f;
    circleLayer.strokeEnd = 0.f;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 3.f;   // 持续时间
    animation.fromValue = @(0); // 从 0 开始
    animation.toValue = @(1);   // 到 1 结束
    // 保持动画结束时的状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // 动画缓慢的进入，中间加速，然后减速的到达目的地。
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [circleLayer addAnimation:animation forKey:@""];
    
   
}


@end
