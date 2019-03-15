//
//  NSObject+XFJBangsManager.h
//  xfj
//
//  Created by Vbon on 2018/10/30.
//  Copyright © 2018 bjy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (demoBangsManager)

//@property (nonatomic, assign, readonly) UIEdgeInsets safeAreaInset;
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
 *  File name       :      NSObject+demoBangsManager.h
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


//@property (nonatomic, assign, readonly) BOOL isBangs;

/**
 全局安全区域
 
 @return <#return value description#>
 */
+ (UIEdgeInsets)safeAreaInset_windows;

/**
 view安全区域
 
 @param view <#view description#>
 @return <#return value description#>
 */
+ (UIEdgeInsets)safeAreaInset:(UIView *)view;

/**
 是否刘海屏

 @return <#return value description#>
 */
+ (BOOL)isBangs;

/**
 当前是否iOS11系统以上

 @return <#return value description#>
 */
+ (BOOL)isIOS11;


/**
 适配iOS11的 UIScrollView 以及 Tableview以下问题
 1、滚动条高度跳动、上下拉刷新问题
 2、列表/页面偏移

 @param scrollView <#scrollView description#>
 */
+ (void)fix_iOS_11_scrollView_offset:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
