//
//  UIButton+Category.m
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "UIButton+Category.h"

#import <objc/runtime.h>

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;
static char kActionKey;
//最小时间差
static NSTimeInterval insensitiveMinTimeInterval = 0.5;
//原生sendAction:to:forEvent:实现
static void (*originalImplementation)(id, SEL, SEL, id, UIEvent *) = NULL;
//替换的sendAction:to:forEvent:实现
static void replacedImplementation(id object, SEL selector, SEL action, id target, UIEvent *event);


@implementation UIButton (CLCategory)

+ (instancetype)bb_ButtonWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize
{
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = frame;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:textColor forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return button;
    }
}

/** 用到了关联 */
- (void)bb_handleWithBlock:(BBButtonActionBlock)actionBlock controlEvent:(UIControlEvents)controlEvent{
    
    //该函数需要四个参数：源对象，关键字，关联的对象和一个关联策略
    objc_setAssociatedObject(self, &kActionKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(bb_callActionBlock:) forControlEvents:controlEvent];
    
}

- (void)bb_callActionBlock:(id)sender{
    
    BBButtonActionBlock block = (BBButtonActionBlock)objc_getAssociatedObject(self, &kActionKey);
    if (block) {
        block(self);
    }
}
- (void)bb_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}



- (CGRect)bb_enlargedRect
{
    NSNumber *topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self bb_enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}




/**
 设置button的titleLabel和imageView的布局<枚举>，及间距
 @param style titleLabel和imageView的样式
 @param space titleLabel和imageView的间距
 */
- (void)bb_LayoutButtonWithEdgeInsetsStyle:(BBButtonEdgeInsetsStyle)style
                           imageTitleSpace:(CGFloat)space
{
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case BBButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case BBButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case BBButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case BBButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
}
/** 摇晃 */
- (void)bb_ButtonShake
{
    CAKeyframeAnimation *animationKey = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animationKey setDuration:0.5f];
    
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [animationKey setValues:array];
    
    
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [animationKey setKeyTimes:times];
    
    
    [self.layer addAnimation:animationKey forKey:@"TextFieldShake"];
}



+ (void)enableInsensitiveTouch {
    //获取当前"@selector(sendAction:to:forEvent:)"对应的Method
    Method methodNow = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    //得到当前sendAction:to:forEvent:实现地址
    IMP implementationNow = method_getImplementation(methodNow);
    //这个实现地址已经是replacedImplementation,说明已经替换过了
    if (implementationNow == (IMP)replacedImplementation) {
        return;
    }
    //保存原生的sendAction:to:forEvent:实现地址
    originalImplementation = (void (*)(id, SEL, SEL, id, UIEvent *))implementationNow;
    const char *type = method_getTypeEncoding(methodNow);
    //将实现替换为replacedImplementation
    class_replaceMethod(self, @selector(sendAction:to:forEvent:), (IMP)replacedImplementation, type);
}

+ (void)disableInsensitiveTouch {
    IMP implementationNow = class_getMethodImplementation(self, @selector(sendAction:to:forEvent:));
    if (originalImplementation && implementationNow == (IMP)replacedImplementation) {
        class_replaceMethod(self, @selector(sendAction:to:forEvent:), (IMP)originalImplementation, NULL);
    }
}

+ (void)setInsensitiveMinTimeInterval:(NSTimeInterval)interval {
    insensitiveMinTimeInterval = interval;
}

- (NSTimeInterval)lastTouchTimestamp {
    return [objc_getAssociatedObject(self, @selector(lastTouchTimestamp)) doubleValue];
}

- (void)setLastTouchTimestamp:(NSTimeInterval)timestamp {
    objc_setAssociatedObject(self, @selector(lastTouchTimestamp), @(timestamp), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//替换的sendAction:to:forEvent:实现
static void replacedImplementation(id object, SEL selector, SEL action, id target, UIEvent *event) {
    //是按钮，并且是UIEventTypeTouches事件，才进行时间戳判断
    //但是要排除这两种按钮 “CUShutterButton”和 "CAMShutterButton"，这两个分别是8系统，10系统上相机拍照按钮的类名.这是两个特殊封装过的按钮，如果把它们的事件也用时间戳给过滤掉了，你就会发现app里弹出相机后，要长按才能拍照。
    if ([object isKindOfClass:UIButton.self] && ![NSStringFromClass([object class]) isEqualToString:@"CUShutterButton"] && ![NSStringFromClass([object class]) isEqualToString:@"CAMShutterButton"] && event.type == UIEventTypeTouches) {
        //进行时间戳判断
        UIButton *button = (UIButton *)object;
        if (ABS(event.timestamp - button.lastTouchTimestamp) < insensitiveMinTimeInterval) {
            //时间过短，就此返回，此次事件Send也中止
            return;
        }
        button.lastTouchTimestamp = event.timestamp;
    }
    //时间戳上没问题，不属于快速点击
    if (originalImplementation) {
        //调用系统原生实现，继续完成事件的Send
        originalImplementation(object, selector, action, target, event);
    }
}


- (void)bb_setGradientBackgroundImage:(UIColor *)fromColor toColor:(UIColor *)toColor {
    
    NSMutableArray *ar = [NSMutableArray arrayWithObjects:(id)fromColor.CGColor, (id)toColor.CGColor, nil];
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([toColor CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(self.bounds.size.width, 0.0);
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)bb_setBackgroundImageWithColor:(UIColor *)color {
    CGRect rect = self.bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:theImage forState:UIControlStateNormal];
}

@end
