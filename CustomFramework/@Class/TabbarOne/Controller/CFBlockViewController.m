//
//  CFBlockViewController.m
//  CustomFramework
//
//  Created by binbin on 2019/2/26.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFBlockViewController.h"
#import "CFRunObject.h"
typedef void(^nameBlock)(NSString * ID);

typedef void(^ageBlock)(void);

@interface CFBlockViewController ()
@property (nonatomic,copy) nameBlock blockName ;
@property (nonatomic,copy) ageBlock aBlock ;

@property (nonatomic,strong) void (^blockD)(void) ;


@property (nonatomic,weak) void (^blockA)(void) ;
@property (nonatomic,copy) void (^blockB)(void) ;
@property (nonatomic,strong) void (^blockC)(void) ;
@end

@implementation CFBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // [self ARC_Block];
    [self setUp_CircularReference];
}



/** MRC 和 ARC 下内存管理 */
- (void)setUp_MemoryManageBlock
{/**
  面试题   Block 是不是一个对象？？？？？？？？ 官方文档有  是一个对象。。
  */
    
    /**
     ARC 只要一个对象没有被强指针修饰就会被销毁，默认局部变量对象是强指针，存放在堆中
    */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //self.blockC();
    NSLog(@"--%@",self.blockD);
    
    //self.blockD();
    
    /**
     用
     weak --nil
     assign --断
     copy strong -- __NSMallocBlock__
     */
    
}

- (void)ARC_Block
{
    
    
    int a = 1;
    void(^blockARC)(void) = ^(void) {
          NSLog(@"--%d",a);
    };
    NSLog(@"--%@",blockARC);
    /**
     如果里面不引用变量a 全局变量block
     如果引用了变量啊 堆变量block
     */
    
    
    self.blockD = blockARC;
    NSLog(@"--属性自定义%@-\n-%@",self.blockD,blockARC);
//    /**
//     如果直接引用a    __NSMallocBlock__  __NSMallocBlock__
//     如果不引用a
//     */
//
//
//    NSLog(@"--%@",^(){
//        NSLog(@"--%d",a);
//        /**
//         如果里面不引用变量a 全局变量block
//         如果引用了变量啊 栈变量block
//         */
//    });
//
//    self.blockA = ^{
//        NSLog(@"--%d",a);
//    };
//    self.blockB = ^{
//        NSLog(@"--%d",a);
//    };
//    self.blockC = ^{
//        NSLog(@"--%d",a);
//    };
//
//
//   // NSLog(@"--weak%@\n--copy%@\n--strong%@\n",self.blockA,self.blockB,self.blockC);
//    /**
//     引用a
//     --weak<__NSStackBlock__: 0x7ffee2a4b328>
//     --copy<__NSMallocBlock__: 0x600003e8edc0>
//     --strong<__NSMallocBlock__: 0x600003e8d8c0>
//     */
//
//
}

- (void)setUp_Block
{
    /** 优点：
     
     捕获外部变量
     降低代码分散程度
     缺点：
     
     循环引用引起内存泄露 */
    /**
     Block 总结
     
     在block内部使用的是将外部变量的拷贝到堆中的（基本数据类型直接拷贝一份到堆中，对象类型只将在栈中的指针拷贝到堆中并且指针所指向的地址不变）。
     __block修饰符的作用：是将block中用到的变量，拷贝到堆中，并且外部的变量本身地址也改变到堆中。
     __block不能解决循环引用，需要在block执行尾部将变量设置成nil
     __weak可以解决循环引用，block在捕获weakObj时，会对weakObj指向的对象进行弱引用。
     使用__weak时，可在block开始用局部__strong变量持有，以免block执行期间对象被释放。
     全局块不引用外部变量，所以不用考虑。
     堆块引用的外部变量，不是原始的外部变量，是拷贝到堆中的副本。
     栈块本身就在栈中，引用外部变量不会拷贝到堆中。
     __weak 本身是可以避免循环引用的问题的，但是其会导致外部对象释放了之后，block 内部也访问不到这个对象的问题，我们可以通过在 block 内部声明一个 __strong 的变量来指向 weakObj，使外部对象既能在 block 内部保持住，又能避免循环引用的问题。
     __block 本身无法避免循环引用的问题，但是我们可以通过在 block 内部手动把 blockObj 赋值为 nil 的方式来避免循环引用的问题。另外一点就是 __block 修饰的变量在 block 内外都是唯一的，要注意这个特性可能带来的隐患。
     block的实现原理是C语言的函数指针。函数指针即函数在内存中的地址，通过这个地址可以达到调用函数的目的。
  
     */
    
    
    
    
    /** 1.Block 的理解以及使用 */
    self.blockName = ^(NSString *ID) {
        CFLog(@"--%@",ID);
    };
    self.blockName(@"110");
    
    
    
    /** 2.Block 内存泄漏问题
     ARC
     */
    
    //2.1
    CFRunObject * objc = [[CFRunObject alloc]init];
    __weak  CFRunObject *objcWeal = objc;
    objc.blockRun = ^{
        /** block会对CFRunObject对象进行一次强引用,导致循环引用无法释放 */
        NSLog(@"---%@",objcWeal);
    };
    objc.blockRun();
    //2.2
    CF_weakSelf(weakSelf);
    self.blockName = ^(NSString *ID) {
        /** Block内部对self进行了一次强引用,导致循环引用无法释放 */
        NSLog(@"---%@",weakSelf);
    };
    
    /**
     
     //1.使用__weak ClassName
     __block XXViewController* weakSelf = self;
     self.blk = ^{
     NSLog(@"In Block : %@",weakSelf);
     };
     
     //2.使用__weak typeof(self)
     __weak typeof(self) weakSelf = self;
     self.blk = ^{
     NSLog(@"In Block : %@",weakSelf);
     };
     
     //3.Reactive Cocoa中的@weakify和@strongify
     @weakify(self);
     self.blk = ^{
     @strongify(self);
     NSLog(@"In Block : %@",self);
     };
     */
    
    
    
    
    /**
     Block为什么要自动从栈区拷贝到堆区呢？
     1.block  为什么 要用copy修饰
     block -- 创建的时候默认分配在栈中 随时会被系统回收 copy 将其拷贝到堆内存中
     
     2.为什么进入Blockd中的对象引用计数需要自动+1
     Block执行的是回调  因此Block并不知道其中的对象obj创建后会在什么时候释放 为了不在Block使用obj之前，对象已经被释放，Block就retain了obj一次
     
     */
    
    
    
    {
        CFLog(@"--Block调用基本数据类型--");
    
    int age = 10; // --auto int age = 10
    
        CFLog(@"age定义前的地址--%p--%d",&age,age);
    self.aBlock = ^{
        /** 内部不能修改 变量的值
         变量是在栈上存放的, 作用域结束时就会被销毁,而 block 执行的函数是在另一个函数方法里, 这个函数是无法访问到 auto age 变量的 ,虽然 block内部也会生成一个一模一样的变量 age 但是这个 age变量 是 block 内部的 不会影响到外部的 auto 变量 age .  因此 block 内部是无法去修改
         */
      //  age = 200;
        CFLog(@"age定义内部的地址--%p--%d",&age,age);
    };
    self.aBlock();
        CFLog(@"ages定义后的地址--%p--%d",&age,age);
    /** 定义前后的地址是一样的  但是内部地址是不一样的
     
    
     流程：
     1. block定义前：a在栈区
     2. block定义内部：里面的a是根据外面的a拷贝到堆中的，不是一个a
     3. block定义后：a在栈区
     */
    }
    
    
    {
        CFLog(@"--block调用 __block修饰的基本数据类型--");
        
        __block int b = 10;
        CFLog(@"block定义前b地址=%p", &b);
        self.aBlock = ^{
            b = 20;
            CFLog(@"block定义内部b地址=%p", &b);
        };
        CFLog(@"block定义后b地址=%p", &b);
        CFLog(@"调用block前 b=%d", b);
        self.aBlock();
        CFLog(@"调用block后 b=%d", b);
    }
    /*
     流程：
     1. 声明 b 为 __block （__block 所起到的作用就是只要观察到该变量被 block 所持有，就将“外部变量”在栈中的内存地址放到了堆中。）
     2. block定义前：b在栈中。
     3. block定义内部： 将外面的b拷贝到堆中，并且使外面的b和里面的b是一个。
     4. block定义后：外面的b和里面的b是一个。
     5. block调用前：b的值还未被修改。
     6. block调用后：b的值在block内部被修改。
     */
    
}



/** 循环引用 Block */
- (void)setUp_CircularReference
{
   /** 1.系统的Block */
    [UIView animateWithDuration:1 animations:^{
        self.view.backgroundColor = [UIColor redColor];
    }];
    
    /** 分析
     原理： UIView的调用的是类方法，当前控制器不可能强引用一个类 ，所以循环无法形成 --> 动画block不会造成循环引用的原因。
     所以通过实践得出第一个结论--> 并不是所有的Block中使用self，都会导致循环引用！
     */
    
    /** 2.	除了系统的 不被引用   还有第三方库 AFNetworking	 */
    /** 3. 那如果是我们自己写的Block，（非系统和AFN），在Block中使用self，是否一定会发生循环引用~
     不会
     
      A 跳转B 控制器 B中有个Block
     
      A中跳转代码
     B * b = [[B alloc] init];
     b.jumpBlock = ^(){
     NSLog(@"%@",self.view);
     }
     
     
     Block -> self 但是self 没有强引用Block
     
     */
    
    /** NSNotifation 会循环引用 重点*/
    
    
}

- (void)dealloc
{
    NSLog(@"--销毁--");
}

@end
