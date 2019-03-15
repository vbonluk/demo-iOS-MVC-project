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
 *  File name       :      demoHudHelper.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "demoHudHelper.h"
#import "ValidateUtil.h"

@implementation demoHudHelper

+ (MBProgressHUD *)showHudWithText:(NSString *)text isStay:(BOOL)isStay{
    UIWindow *currentWindow = [[UIApplication sharedApplication] keyWindow];
    /** 防止重复弹框 **/
    NSEnumerator *subviewsEnum = [currentWindow.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:MBProgressHUD.class]) {
            MBProgressHUD *previousHud = (MBProgressHUD *)subview;
            if ([previousHud.label.text isEqualToString:text]) {
                return previousHud;
            }
        }
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentWindow animated:YES];
    hud.label.text = text;
    if (isStay) {
        hud.mode = MBProgressHUDModeIndeterminate;
        [hud showAnimated:YES];
    } else {
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:[self calculateHUDHiddenTimeWithText:hud.label.text]];
    }
    
    return hud;
}

+ (MBProgressHUD *)showHudWithText:(NSString *)text isStay:(BOOL)isStay hideCompletionBlock:(void(^)(void))hideCompletionBlock{
    UIWindow *currentWindow = [[UIApplication sharedApplication] keyWindow];
    /** 防止重复弹框 **/
    NSEnumerator *subviewsEnum = [currentWindow.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:MBProgressHUD.class]) {
            MBProgressHUD *previousHud = (MBProgressHUD *)subview;
            if ([previousHud.label.text isEqualToString:text]) {
                return previousHud;
            }
        }
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentWindow animated:YES];
    [hud setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (hideCompletionBlock) {
                hideCompletionBlock();
            }
        });
    }];
    hud.label.text = text;
    if (isStay) {
        hud.mode = MBProgressHUDModeIndeterminate;
        [hud showAnimated:YES];
    } else {
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:[self calculateHUDHiddenTimeWithText:hud.label.text]];
    }
    
    return hud;
}

/**
 计算HUD消失的最佳时间
 
 @param text HUD文本内容
 @return 最佳消失时间
 */
+ (CGFloat)calculateHUDHiddenTimeWithText:(NSString *)text{
    if ([ValidateUtil validateContainChineseStr:text]) {
        if (text.length < 5) {
            return 2.0;
        } else {
            //提取中文字数
            NSInteger countChinese = 0;
            for(int i=0; i< [text length];i++){
                int a = [text characterAtIndex:i]; if( a > 0x4e00 && a < 0x9fff){
                    countChinese ++;
                }
            }
            //在中文字数大于5个字后，每多5个字增加一秒阅读时间
            CGFloat time = countChinese / 5.f;
            return time;
        }
    }else{
        //因为默认2秒时间
        return 2.0;
    }
}

+ (void)hidenHud{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    });
}

@end
