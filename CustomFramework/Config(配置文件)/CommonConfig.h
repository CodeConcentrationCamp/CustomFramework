//
//  CommonConfig.h.h
//  CustomFramework
//
//  Created by binbin on 2019/1/24.
//  Copyright © 2019 cbb. All rights reserved.
//

#ifndef CommonConfig_h_h
#define CommonConfig_h_h

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

#endif /* CommonConfig_h_h */
