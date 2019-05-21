//
//  UILabel+Category.m
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "UILabel+Category.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>
@implementation UILabel (Category)

/**
 快速创建label
 */
+ (instancetype)bb_LabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment
{
    UILabel * customLabel =[[UILabel alloc]initWithFrame:frame];
    customLabel.text = [NSString stringWithFormat:@"%@",text];
    customLabel.textColor=color;
    customLabel.textAlignment=textAlignment;
    customLabel.font = [UIFont systemFontOfSize:fontSize];
    return customLabel;
}


- (void)setColumnSpace:(CGFloat)columnSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

- (void)setRowSpace:(CGFloat)rowSpace
{
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

// 设置字体的大小
- (void)settingLabelTextKitWithText:(NSString *)text withLabelFont:(UIFont *)font
{
    
    if (text == nil) {
        return;
    }
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    //1.设置字体
    //    NSRange rg = NSMakeRange(0, 3);
    NSRange rg = [self.text rangeOfString:text];
    [attrstring addAttribute:NSFontAttributeName
                       value:font
                       range:rg];
    
    
    self.attributedText = attrstring;
    
    
}

- (void)settingLabelTextKitWithText:(NSString *)text withLabelFont:(UIFont *)font withLabelTextColor:(UIColor *)textColor
{
    if (text != nil) {
        NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
        //2.设置字体颜色
        NSRange rg = [self.text rangeOfString:text];
        [attrstring addAttribute:NSFontAttributeName
                           value:font
                           range:rg];
        
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:[self.text rangeOfString:text]];
        
        self.attributedText = attrstring;
    }
}

- (void)settingLabelTextColor:(UIColor *)textColor withStr:(NSString *)text
{
    if (text != nil) {
        NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
        
        //2.设置字体颜色
        
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:[self.text rangeOfString:text]];
        
        self.attributedText = attrstring;
    }
}

- (void)settingLabelBackgroundColor:(UIColor *)backgroundColor withStr:(NSString *)text
{
    
    if (text == nil) {
        return;
    }
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    //3.设置字体的背景颜色
    [attrstring addAttribute:NSBackgroundColorAttributeName
                       value:backgroundColor
                       range:[self.text rangeOfString:text]];
    
    
    self.attributedText = attrstring;
    
    
    
}


- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text withLabelFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor
{
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    //    NSLog(@"self.text = %@  text = %@",self.text,text);
    NSRange range;
    if (text != nil && text.length > 0) {
        
        range = [self.text rangeOfString:text];
        [attrstring addAttribute:NSFontAttributeName
                           value:font
                           range:range];
        
        //2.设置字体颜色
        
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:range];
        
        //3.设置字体的背景颜色
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:backgroundColor
                           range:range];
        
        
        self.attributedText = attrstring;
    }
}



- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor
                                    secondText:(NSString *)secondText
                                    secondFont:(UIFont *)secondFont
                               secondTextColor:(UIColor *)secondTextColor

{
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range;
    NSRange range2;
    if (text != nil) {
        range = [self.text rangeOfString:text];
        [attrstring addAttribute:NSFontAttributeName
                           value:font
                           range:range];
        //2.设置字体颜色
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:range];
        //3.设置字体的背景颜色
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:backgroundColor
                           range:range];
        
        
        range2 = [self.text rangeOfString:secondText];
        [attrstring addAttribute:NSFontAttributeName
                           value:secondFont
                           range:range2];
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:secondTextColor
                           range:range2];
        
        self.attributedText = attrstring;
        
        
        
    }
    
    
}


- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor
                                    secondText:(NSString *)secondText
                                    secondFont:(UIFont *)secondFont
                               secondTextColor:(UIColor *)secondTextColor
                         secondBackgroundColor:(UIColor *)secondBackgroundColor
{
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range;
    NSRange range2;
    if (text != nil && secondText != nil) {
        range = [self.text rangeOfString:text];
        [attrstring addAttribute:NSFontAttributeName
                           value:font
                           range:range];
        //2.设置字体颜色
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:range];
        //3.设置字体的背景颜色
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:backgroundColor
                           range:range];
        
        
        range2 = [self.text rangeOfString:secondText];
        [attrstring addAttribute:NSFontAttributeName
                           value:secondFont
                           range:range2];
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:secondTextColor
                           range:range2];
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:secondBackgroundColor
                           range:range2];
        
        self.attributedText = attrstring;
        
        
        
    }
    
}

-(void)settingLabelTextColor:(UIColor*)textcolor range:(NSString*)string1 textColorTwo:(UIColor*)textcolortwo range:(NSString*)stringtwo
{
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range = NSMakeRange([[attrstring string] rangeOfString:string1].location, [[attrstring string] rangeOfString:string1].length);
    [attrstring addAttribute:NSForegroundColorAttributeName value:textcolor range:range];
    NSRange rangetwo = NSMakeRange([[attrstring string] rangeOfString:stringtwo].location, [[attrstring string] rangeOfString:stringtwo].length);
    [attrstring addAttribute:NSForegroundColorAttributeName value:textcolortwo range:rangetwo];
    
    self.attributedText = attrstring;
}

-(void)settingLabelTextColor:(UIColor*)textcolor range:(NSString*)string1 textColorTwo:(UIColor*)textcolortwo range:(NSString*)stringtwo textcolorthree:(UIColor*)textcolorthree range:(NSString *)stringthree
{
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range = NSMakeRange([[attrstring string] rangeOfString:string1].location, [[attrstring string] rangeOfString:string1].length);
    [attrstring addAttribute:NSForegroundColorAttributeName value:textcolor range:range];
    NSRange rangetwo = NSMakeRange([[attrstring string] rangeOfString:stringtwo].location, [[attrstring string] rangeOfString:stringtwo].length);
    [attrstring addAttribute:NSForegroundColorAttributeName value:textcolortwo range:rangetwo];
    
    NSRange rangethree = NSMakeRange(attrstring.length - 1, 1);
    [attrstring addAttribute:NSForegroundColorAttributeName value:textcolorthree range:rangethree];
    
    self.attributedText = attrstring;
}

@end
