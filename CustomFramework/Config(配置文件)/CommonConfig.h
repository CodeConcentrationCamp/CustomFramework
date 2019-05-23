//
//  CommonConfig.h.h
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#ifndef CommonConfig_h_h
#define CommonConfig_h_h

#ifdef DEBUG
//调试状态
#define MyString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define CFLog(...) NSLog(@"%s: %s (%@方法) 第%d行: %s\n\n",[[ManagementTool getCurrentDate] UTF8String], [MyString UTF8String] ,NSStringFromSelector(_cmd),__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
//发布状态
#define CFLog(...)
#endif


/** 尺寸 */
#define CF_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define CF_ScreenHeight [UIScreen mainScreen].bounds.size.height

/** tabBar 的高度 */
#define CF_tabbarHeight ((CF_ScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 83 : 49)
/** nav 的高度 */
#define SafeAreaTopHeight ((CF_ScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 88 : 64)


#define CF_statusbarHeight ((CF_ScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 44 : 20)

#define SafeAreaBottomHeight ((CF_ScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"]  ? 30 : 0)

/// 解决循环引用，用__weak 来修饰
#define CF_weakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/** 懒加载 */
#define CF_OBJECT_LAZY(_objc,_content) (_objc =_objc ? : _content)


/** 字符串是否为空 */
#define  CF_StringIsEmpty(string)   (string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0  || [string isKindOfClass:[NSNull class]] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])  ? YES : NO


#endif /* CommonConfig_h_h */
