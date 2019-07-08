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
#import "CFDataPersistenceModel.h"
@interface CFRunTimeDetailViewController ()
@property (nonatomic,strong)  NSData * data ;

@end

@implementation CFRunTimeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // [self setUp_RunTimeMsg];
    
    [self setUp_RunTimeArchivingAnFiling];
   
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
  
    
    CFRunObject * obj = [[CFRunObject alloc]init];
    Class c1 = [obj class];
    Class c2 = [CFRunObject class];
    /** 获取的一样
     c1是通过一个实例对象获取的Class，实例对象可以获取到其类对象，
            类名作为消息的接受者时代表的是类对象，因此类对象获取Class得到的是其本身
     
     类对象是一个单例的想法
     
     */
  //  NSLog(@" --%@--%@ 地址--%p,--%p",c1,c2,c1,c2);
    /**
     
        1.class_isMetaClass用于判断Class对象是否为元类
        class_isMetaClass函数，如果是cls是元类，则返回YES；如果否或者传入的cls为Nil，则返回NO。
     
        2.object_getClass用于获取对象的isa指针指向的对象。
     
     */
  
    
    CFLog(@"--%@---%@",object_getClass(c1),c1);
    CFLog(@"--%@---%@",object_getClass(c2),c2);
    CFLog(@"obj--对象的isa指针指向的对象--%@",object_getClass(c1));
    CFLog(@"CFRunObject--对象的isa指针指向的对象--%@",object_getClass(c2));

    /**obj  CFRunObject 都不是元类   他们的isa指针指向的对象是元类 */
    CFLog(@"obj--对象是不是元类--%d",class_isMetaClass(c1));
    CFLog(@"CFRunObject--对象是不是元类--%d",class_isMetaClass(c2));
    CFLog(@"--对象是不是元类--%d",class_isMetaClass(object_getClass(c1)));
    CFLog(@"--对象是不是元类--%d",class_isMetaClass(object_getClass(c2)));
    CFLog(@"NSObject--对象是不是元类--%d",class_isMetaClass([NSObject class]));
    
    
    //输出1
    NSLog(@"%d", [obj class] == object_getClass(obj));
    //输出0
    NSLog(@"%d", class_isMetaClass(object_getClass(obj)));
    //输出1
    NSLog(@"%d", class_isMetaClass(object_getClass([CFRunObject class])));
    //输出1
    NSLog(@"%d", class_isMetaClass(object_getClass([obj class])));
    //输出0
    NSLog(@"%d", object_getClass(obj) == object_getClass([CFRunObject class]));
    /** 总结
     一个实例对象通过class方法获取的Class--就是它的isa指针指向的类对象，
     而类对象不是元类，类对象的isa指针指向的对象是元类
     */
    
    
    /**
     3. 获取类的父类
     Class class_getSuperclass ( Class cls );
     指向该类的父类，如果该类已经是最顶层的根类(如NSObject或NSProxy)，则super_class为NULL。
     class_getSuperclass函数，当cls为Nil或者cls为根类时，返回Nil。
     不过通常我们可以使用NSObject类的superclass方法来达到同样的目的
     */
    NSLog(@"--父类%@ --%@ --%@",class_getSuperclass(c1),class_getSuperclass(c2),class_getSuperclass([NSObject class]));
    /**
     4. 获取类的类名
     const char * class_getName ( Class cls );
     */
    NSLog(@"--类名%s--%s--%s--%s",class_getName(c1),class_getName(c2),class_getName([NSObject class]),class_getName(nil));
    
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
    
    CFRunObject * runObject = [[CFRunObject alloc]init];
    [runObject sleep];
   
    /**
     字符串转方法
     NSSelectorFromString(@"")
     方法字符串
     NSStringFromSelector(SEL)
     BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
     作用：这个方法的作用是，给类添加一个新的方法和该方法的具体实现
     */
    
    
}

/** 分类中增加方法变量属性    ？？  类别 为什么不能增加属性 ？？-- 怎么才能给类别增加属性 */
- (void)setUp_RunTimeIncreaseVariable
{
    
    
    
}

/** 字典转模型 dynamic ？？？ 什么叫重定向？？？ */
- (void)setUp_RunTimeDicConversionModel
{
    /**  YYModle  框架解析*/
}


/** runtime 实现归档解档 */
- (void)setUp_RunTimeArchivingAnFiling
{
    
    /** 1.-- 常规的写法 NSKeyedArchiver ios11 之后新方法 使用 没有路径 -- */
     /** 归档 */
     [self archiveObject];
     /** 解档 */
  //   [self unarchiverObject];
    /** 使用runTime 写法 */
    
}

- (void)archiveObject{
    CFDataPersistenceModel *model = [[CFDataPersistenceModel alloc] init];
    model.name = @"小白";
    model.age = @"25";
    model.sex = @"Nan";
    model.IDCard = @"110";

    // 保存自定义对象
    NSError * error = nil;
    self.data = [NSKeyedArchiver archivedDataWithRootObject:model requiringSecureCoding:YES error:&error];
    if (self.data == nil || error) {
        NSLog(@"归档失败:%@", error);
        return;
    }
    
}

- (void)unarchiverObject
{

    NSError * error = nil;
    CFDataPersistenceModel *model = [NSKeyedUnarchiver unarchivedObjectOfClass:[CFDataPersistenceModel class] fromData:self.data error:&error];
    if (model == nil || error) {
        NSLog(@"解档失败:%@", error);
        return;
    }
   // NSLog(@"%@ %@",model.name,model.age);

}

@end
