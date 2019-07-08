
//
//  CFDataPersistenceModel.m
//  CustomFramework
//
//  Created by binbin on 2019/5/27.
//  Copyright © 2019 cbb. All rights reserved.
//

#import "CFDataPersistenceModel.h"
#import "NSObject+RunTimeCode.h"

@implementation CFDataPersistenceModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    /**
     
     方法一:
     • encodeWithCoder什么时候调用：对象归档时候调用
     • encodeWithCoder作用：告诉系统对象里的哪些属性需要归档，怎么去归档，根据一个key去归档，目的就是以后取的时候，也根据这个key去取数据。
     */
//       [aCoder encodeObject:_name forKey:@"name"];
//       [aCoder encodeObject:_age forKey:@"age"];
//       [aCoder encodeObject:_sex forKey:@"sex"];
//       [aCoder encodeObject:_IDCard forKey:@"IDCard"];
    
    
    /** 方法二 */
    [self encoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
     /**
      方法一
      • initWithCoder作用：告诉系统对象里的哪些属性需要解档，怎么去解档，根据之前存储的key去解档
      • initWithCoder是一个初始化方法，需要先初始化父类的，但是不能调用[super initWithCoder:],因为父类NSObject没有遵守NSCoding协议。
      initWithCoder什么时候需要调用[super initWithCoder:]
      • initWithCoder原理:只要解析文件就会调用，xib,storyboard都是文件，因此只要解析这两个文件，就会调用initWithCoder。
      • 因此如果在storyboard使用自定义view,重写initWithCoder方法，一定要调用[super initWithCoder:]，因为只有系统才知道怎么解析storyboard，如果没有调用，就解析不了这个文件。
      */
    
    
    
    self = [super init];
    if (self) {
        /**
         方法一
         _name = [aDecoder decodeObjectForKey:@"name"];
         _age = [aDecoder decodeObjectForKey:@"age"];
         _sex = [aDecoder decodeObjectForKey:@"sex"];
         _IDCard = [aDecoder decodeObjectForKey:@"IDCard"];
         */
        
        /** 方法二 */
        [self decoder:aDecoder];
    }
    
    return self;
    
}

/**
 支持加密编码
 */
+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
