//
//  CFRunTimeDetailViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/5/22.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFRunTimeDetailViewController.h"
#import <objc/message.h>
#import "CFRunObject.h"
#import "CFToolsObject.h"
@interface CFRunTimeDetailViewController ()

@end

@implementation CFRunTimeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RunTime";
    self.view.backgroundColor = [UIColor whiteColor];
   // [self setUp_RunTimeMsg];
    
    [self setUp_RunTimeExchangeMethod];
    NSLog(@"--%@",[self description]);
}

/** runtime的介绍 */
- (void)setUp_RunTime
{
    /** 面试RunTime？？？ 什么是RunTime??   有什么作用??  */
    
    /** 1.什么是runtime
     
     runtime是运行时,是一套比较底层的C语言API
     平时编写的OC代码，需要Runtime来创建类和对象，进行消息发送和转发，其实最终会转换成Runtime的C语言代码。
     runtime是将数据类型的确定由编译时推迟到了运行时
     
     
     为什么需要 runtime
     只要是oc是动态的语言  能将数据类型的确定由编译时推迟到了运行时  这是使用runtime的 一个很重要原因
     */
    
    
    /** 2.runtime 有什么作用
     消息传递、转发<消息机制>
     访问私有变量 -- UITextFiled 的修改
     交换系统方法
     动态增加方法
     为分类增加属性，变量
     字典转模型
     */
    
}


/** 代码 的意义 */
- (void)setUp_RunTimeCodeing
{
   /**
    
    
    // 添加方法
    BOOL class_addMethod ( Class cls, SEL name, IMP imp, const char *types );
    // 获取实例方法
    Method class_getInstanceMethod ( Class cls, SEL name );
    // 获取类方法
    Method class_getClassMethod ( Class cls, SEL name );
    // 获取所有方法的List
    Method * class_copyMethodList ( Class cls, unsigned int *outCount );
    // 替代方法的实现
    IMP class_replaceMethod ( Class cls, SEL name, IMP imp, const char *types );
    // 返回方法的具体实现
    IMP class_getMethodImplementation ( Class cls, SEL name );
    IMP class_getMethodImplementation_stret ( Class cls, SEL name );
    // 类实例是否响应指定的selector
    BOOL class_respondsToSelector ( Class cls, SEL sel );
    ⚠️：当判断一个实例方法是否实现时，第一个参数要用类对象，也就是[Person class]。
    当判断一个类方法是否实现时，第一个参数要传元类，也就是object_getClass([Person class])。
    
    
    */
}

/** 消息机制 */
- (void)setUp_RunTimeMsg
{
    /** 消息机制  ？？？ 消息机制的原理？？  面试题*/
    /**
     过程
     
     首先通过方法编号SEL 去类实现的list表中查找 实现的IMP 直到找到为止
     如果找不到- - 就会开始进入动态法法解析
     
     1.消息机制的原理
        消息机制原理:对象根据方法编号SEL去映射表查找对应的方法实现
     */
    CFRunObject * runObject = objc_msgSend([CFRunObject class], @selector(alloc));
    runObject = objc_msgSend(runObject, sel_registerName("init"));
    objc_msgSend(runObject, @selector(eat));
    /** 传递了两个隐藏函数
      self 接受消息的对象
      _cmd  方法选择器
     
     
     */
    
}

/** 访问私有的属性 变量 */
- (void)setUp_RunTimeGoToPriVariable
{
    
    /** 通过 通过runtime 改变占位符  kvc  */
    UITextField * textField = [[UITextField alloc]initWithFrame:CGRectZero];
    textField.placeholder = @"请输入用户名";
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:textField];
}

/** 交换方法 -- 拦截   按钮点击的拦截  */
- (void)setUp_RunTimeExchangeMethod
{
    /** 1.拦截应用 防止UI控件短时间多次激活事件 本APP所有的按钮2秒内不可连续点击？？？？？
     class_addMethod,class_replaceMethod,method_exchangeImplementations
     
     
     
     
     BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
     作用：这个方法的作用是，给类添加一个新的方法和该方法的具体实现
     BOOL: 返回值，yes-------方法添加成功    no--------方法添加失败
     Class cls: 将要给添加方法的类，传的类型 ［类名  class］
     SEL name: 将要添加的方法名，传的类型   @selector(方法名)
     IMP imp：实现这个方法的函数 ，传的类型   1，C语言写法：（IMP）方法名    2，OC的写法：class_getMethodImplementation(self,@selector(方法名：))
     const char *types :????
     */
    
    CFRunObject * runObject = [[CFRunObject alloc]init];
    [runObject eat];
    
    
}

/** 动态增加方法 */
- (void)setUp_RunTimeDynamicIncreaseMethod
{
    
}

/** 分类中增加方法变量属性    ？？  类别 为什么不能增加属性 ？？-- 怎么才能给类别增加属性 */
- (void)setUp_RunTimeIncreaseVariable
{
    
}

/** 字典转模型 dynamic ？？？ 什么叫重定向？？？ */
- (void)setUp_RunTimeDicConversionModel
{
    
}




@end
