//
//  NSObject+XFJBangsManager.m
//  xfj
//
//  Created by Vbon on 2018/10/30.
//  Copyright © 2018 bjy. All rights reserved.
//

#import "NSObject+demoBangsManager.h"

@implementation NSObject (demoBangsManager)

+ (UIWindow *)keyWindow {
    return [UIApplication sharedApplication].keyWindow;
}

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
 *  File name       :      NSObject+demoBangsManager.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


+ (UIEdgeInsets)safeAreaInset_windows {
    if (@available(iOS 11.0, *)) {
        if ([NSObject keyWindow]) {
            return [NSObject keyWindow].safeAreaInsets;
        }
    }
    return UIEdgeInsetsZero;
}

/**
 view安全区域

 @param view <#view description#>
 @return <#return value description#>
 */
+ (UIEdgeInsets)safeAreaInset:(UIView *)view {
    if (@available(iOS 11.0, *)) {
        if (view) {
            return view.safeAreaInsets;
        }
    }
    return UIEdgeInsetsZero;
}

/**
 是否刘海屏

 @return <#return value description#>
 */
+ (BOOL)isBangs {
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return [self safeAreaInset_windows].left > 0.0f;
    }else {
        // ios12 非刘海屏状态栏 20.0f
        return [self safeAreaInset_windows].top > 20.0f;
    }
}

/**
 当前是否iOS11系统以上
 
 @return <#return value description#>
 */
+ (BOOL)isIOS11{
    if (@available(iOS 11.0, *)){
        return YES;
    }
    return NO;
}

/**
 适配iOS11的 UIScrollView 以及 Tableview以下问题
 1、滚动条高度跳动、上下拉刷新问题
 2、列表/页面偏移
 
 @param scrollView <#scrollView description#>
 */
+ (void)fix_iOS_11_scrollView_offset:(UIScrollView *)scrollView{
    //解决iOS11以后，列表/页面滚动偏移
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    //解决iOS11以后，滚动条高度跳动、上下拉刷新问题
    if ([self isIOS11] && [scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tb = (UITableView *)scrollView;
        tb.estimatedRowHeight = 0;
        tb.estimatedSectionHeaderHeight = 0;
        tb.estimatedSectionFooterHeight = 0;
    }
}


@end
