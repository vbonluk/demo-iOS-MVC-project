//
/*
 *
 *
 *               dddddddd
 *               d::::::d
 *               d::::::d
 *               d::::::d
 *               d:::::d
 *       ddddddddd:::::d     eeeeeeeeeeee       mmmmmmm    mmmmmmm      ooooooooooo
 *     dd::::::::::::::d   ee::::::::::::ee   mm:::::::m  m:::::::mm  oo:::::::::::oo
 *    d::::::::::::::::d  e::::::eeeee:::::eem::::::::::mm::::::::::mo:::::::::::::::o
 *   d:::::::ddddd:::::d e::::::e     e:::::em::::::::::::::::::::::mo:::::ooooo:::::o
 *   d::::::d    d:::::d e:::::::eeeee::::::em:::::mmm::::::mmm:::::mo::::o     o::::o
 *   d:::::d     d:::::d e:::::::::::::::::e m::::m   m::::m   m::::mo::::o     o::::o
 *   d:::::d     d:::::d e::::::eeeeeeeeeee  m::::m   m::::m   m::::mo::::o     o::::o
 *   d:::::d     d:::::d e:::::::e           m::::m   m::::m   m::::mo::::o     o::::o
 *   d::::::ddddd::::::dde::::::::e          m::::m   m::::m   m::::mo:::::ooooo:::::o
 *    d:::::::::::::::::d e::::::::eeeeeeee  m::::m   m::::m   m::::mo:::::::::::::::o
 *     d:::::::::ddd::::d  ee:::::::::::::e  m::::m   m::::m   m::::m oo:::::::::::oo
 *      ddddddddd   ddddd    eeeeeeeeeeeeee  mmmmmm   mmmmmm   mmmmmm   ooooooooooo
 *
 *
 *  File created    :      2019/03/15
 *  File name       :      demo_TOOLS_DEFINE.h
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    
#import "AppDelegate.h"

#ifndef demo_TOOLS_DEFINE_h
#define demo_TOOLS_DEFINE_h

// APPDELEGATE
#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
// 设备高度
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
// 设备宽度
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width

// 主题色
#define kIAThemeColor HEXCOLOR(0xcfa972)
// 分割线颜色
#define kIASplitLineColor HEXCOLOR(0xeeeeee)
// tableview背景颜色
#define kIATableBgColor HEXCOLOR(0xececec)
// 字体颜色333333
#define kIAFontColor333333 HEXCOLOR(0x333333)
// 字体颜色666666
#define kIAFontColor666666 HEXCOLOR(0x666666)
// 字体颜色999999
#define kIAFontColor999999 HEXCOLOR(0x999999)

// 默认字号
#define kIAFontSizeNormal 15
// 默认字号
#define kIAFontSizeSmall 12
// 默认Font
#define kIAFontNormal [UIFont systemFontOfSize:kIAFontSizeNormal]
// 默认Font
#define kIAFontSmall [UIFont systemFontOfSize:kIAFontSizeSmall]

// rgb颜色转换（16进制->10进制）
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

// 状态栏高度
#define demoStatusHeight [[UIApplication sharedApplication]statusBarFrame].size.height

// 导航栏高度
#define demoNavHeight 44 // 自定义导航栏

// tabBar高度
#define demoTabBarHeight self.tabBarController.tabBar.frame.size.height

// 头像占位图
#define demoDefaultProfilePhoto [UIImage imageNamed:@"defaultProfilePhoto"]

// 默认占位图 50 x 50
#define demoDefaultPlaceholderImage50X50 [UIImage imageNamed:@"demoDefaultPlaceholderImage50X50"]

// 默认占位图 100 x 100
#define demoDefaultPlaceholderImage100X100 [UIImage imageNamed:@"demoDefaultPlaceholderImage100X100"]

// 默认占位图 200 x 200
#define demoDefaultPlaceholderImage200X200 [UIImage imageNamed:@"demoDefaultPlaceholderImage200X200"]

// 默认占位图 320 x 200
#define demoDefaultPlaceholderImage320X200 [UIImage imageNamed:@"demoDefaultPlaceholderImage320X200"]

// APP检查更新 时间保存
#define demo_DATA_TIME_CHECK_VERSION_UPDATE @"demo_DATA_TIME_CHECK_VERSION_UPDATE"

// APP检查更新 周期设置 1天  24小时
#define requestVersionOnceTime 24

#endif /* demo_TOOLS_DEFINE_h */
