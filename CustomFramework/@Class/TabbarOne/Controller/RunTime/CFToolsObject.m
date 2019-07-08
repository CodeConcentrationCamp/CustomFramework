//
//  CFToolsObject.m
//  CustomFramework
//
//  Created by binbin on 2019/5/23.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFToolsObject.h"
#import "CFRunObject.h"
#import <objc/message.h>
#import <objc/runtime.h>
@implementation CFToolsObject

- (void)toolEat
{
    CFLog(@"--gaibianEat");
}

/**
 Apple的文档很清楚地说明了initialize和load的区别在于：load是只要类所在文件被引用就会被调用，而initialize是在类或者其子类的第一个方法被调用前调用。所以如果类没有被引用进项目，就不会有load调用；但即使类文件被引用进来，但是没有使用，那么initialize也不会被调用。
 
 它们的相同点在于：方法只会被调用一次。（其实这是相对runtime来说的，后边会做进一步解释）。
 */
+ (void)load
{
    // 防止手动调用 class 方法，保证替换方法只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /**
        改变CFRunObject eat方法
        写一个CFToolsObject 中增加一个toolEat
         */
       
    
        

        /** eat 原方法 */
        Method oriMethod = class_getInstanceMethod([CFRunObject class], @selector(eat));
        Method curMethod = class_getInstanceMethod([CFToolsObject class], @selector(toolEat));
        
        ////先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
        /** 可能原方法中没有实现  为了 增加实现 */
        /**
         
         class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,
         const char * _Nullable types)
         
         *  Class cls     cls 参数表示需要添加新方法的类。
         *  SEL name      name 参数表示 selector 的方法名称，可以根据喜好自己进行命名。
         *  IMP imp       imp 即 implementation ，表示由编译器生成的、指向实现方法的指针。也就是说，这个指针指向的方法就是我们要添加的方法。
         *  const char *types   最后一个参数 *types 表示我们要添加的方法的返回值和参数。
         
         如果发现方法已经存在，会失败返回，也可以用来做检查是否已经添加过方法了,我们这里是为了避免源方法没有实现的情况;
         如果方法没有存在,我们则先尝试添加被替换的方法的实现
         */
        BOOL addSucc = class_addMethod([CFRunObject class], @selector(eat), method_getImplementation(curMethod), method_getTypeEncoding(curMethod));
        NSLog(@"-%d",addSucc);
        
        /**
         
        
         判断class_addMethod是否已经添加成功了
         YES 则说明被替换方法不存在.也就是被替换的方法没有被实现,我们需要先把这个方法实现,然后再执行我们想要的效果,用我们自定义的方法去替换被替换的方法. 这里使用到的是class_replaceMethod这个方法. class_replaceMethod本身会尝试调用class_addMethod和method_setImplementation，所以直接调用class_replaceMethod就可以了)
         
         NO  则说明被替换方法已经存在.直接将两个方法的实现交换即
         */
         
        if (addSucc) {
            // 添加成功：将源方法的实现替换到交换方法的实现
            class_replaceMethod([CFToolsObject class], @selector(toolEat), method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
            
        }else {
            //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
            method_exchangeImplementations(oriMethod, curMethod);
        }
    });
    
   
}

@end
