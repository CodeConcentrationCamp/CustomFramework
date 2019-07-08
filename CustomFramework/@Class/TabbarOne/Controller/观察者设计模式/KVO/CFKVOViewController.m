
//
//  CFKVOViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/6/3.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFKVOViewController.h"

@interface CFKVOViewController ()
@property (nonatomic,copy) NSString *kvoString ;
@property (nonatomic,copy) NSString *changValue ;
@property (nonatomic,strong)UILabel * changLabel ;
@end

@implementation CFKVOViewController

- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor whiteColor];
  
   // [self setUp_KVODetailOne];
    [self setUp_KVODetailTwo];
   
}

- (void)setkvoString:(NSString *)kvoString{
    [self willChangeValueForKey:@"kvoString"];
    _kvoString = [kvoString copy];
    [self didChangeValueForKey:@"kvoString"];
}


+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    
    if ([key isEqualToString:@"kvoString"]) {
        return YES;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

- (void)setUp_KVODetailOne
{
    
    /**
     
     注意，KVO的运行是通过重写setter方法来触发通知机制的，也就是说，如果你直接赋值给实例变量而不是使用属性赋值的话，是不会触发KVO的。也就是说，下面的self.kvoString如果换成了_kvoString是无效的，因为self.kvoString赋值时调用了setter方法。但是使用KVC来给实例变量赋值，会触发KVO。
     */
  
    self.kvoString = @"1";
    [self addObserver:self forKeyPath:@"kvoString" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    self.kvoString = @"2";
    _kvoString = @"3";
    self.kvoString = @"4";
}


- (void)setUp_KVODetailTwo
{
      self.changValue = @"0";
     [self addObserver:self forKeyPath:@"changValue" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew  context:nil];
    UILabel * changLabel = [UILabel bb_LabelWithFrame:CGRectMake(0, 100, CF_ScreenWidth, 30) text:self.changValue textColor:[UIColor redColor] fontSize:20 textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:changLabel];
    self.changLabel =changLabel;
    
   
    
    
}

 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
  
    /**
     1.change参数
     除了根据options参数控制的change参数内容，默认change参数会包含一个NSKeyValueChangeKindKey键值对，传递被监听属性的变化类型：
     */
    
    NSLog(@"keyPath:%@\nobject:%@\nchange:%@\ncontext:%@",keyPath,object,change,context);
    
    if ([keyPath isEqualToString:@"kvoString"] ) {
       for (NSString  *key in change) {
            NSLog(@"%@",key);
            NSLog(@"%@",change[key]);
        }
    }else if ([keyPath isEqualToString:@"changValue"] )
    {
        // 响应变化处理：UI更新（label文本改变）
        self.changLabel.text = [NSString stringWithFormat:@"当前的num值为：%@",
                           [change valueForKey:@"new"]];
        
        //上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\noldnum:%@ newnum:%@",
              [change valueForKey:@"old"],
              [change valueForKey:@"new"]);
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.changValue = [NSString stringWithFormat:@"%ld",[self.changValue integerValue] + 1];
}

- (void)dealloc{
    
    //[self removeObserver:self forKeyPath:@"kvoString"];
     [self removeObserver:self forKeyPath:@"changValue"];
    
}



@end
