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
 *  File name       :      demoUserInfoManager.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "demoUserInfoManager.h"
#import <YYModel.h>

static demoUserInfoManager* _instance = nil;

@implementation demoUserInfoManager

+ (instancetype) shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    }) ;
    
    return _instance ;
}

/**
 获取用户信息实体

 @return 返回用户信息实体
 */
+ (demoUserInfoModel *)getUserInfoModel{
    NSString *userInfoStr = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoString];
    if ([StringUtil empty:userInfoStr] == NO) {
        demoUserInfoModel *userInfoModel = [demoUserInfoModel yy_modelWithJSON:userInfoStr];
        if (userInfoModel && [userInfoModel isKindOfClass:demoUserInfoModel.class]) {
            return userInfoModel;
        }
    }
    return nil;
}

/**
 存储用户信息

 @param model 用户信息实体
 */
+ (void)saveUserInfoModelWithModel:(demoUserInfoModel *)model{
    if (model && [model isKindOfClass:demoUserInfoModel.class]) {
        NSString *userInfoJSON = [model yy_modelToJSONString];
        if (userInfoJSON && [StringUtil empty:userInfoJSON] == NO && [userInfoJSON isKindOfClass:NSString.class]) {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:userInfoJSON forKey:kUserInfoString];
            [ud synchronize];
        }
    }
}

/**
 存储用户信息

 @param key 属性
 @param value 值
 */
+ (void)saveUserInfoModelWithKey:(NSString *)key value:(id)value{
    demoUserInfoModel *userInfoModel = nil;
    NSString *userInfoStr = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoString];
    if ([StringUtil empty:userInfoStr] == NO) {
        userInfoModel = [demoUserInfoModel yy_modelWithJSON:userInfoStr];
        if (userInfoModel && [userInfoModel isKindOfClass:demoUserInfoModel.class]) {
            @try {
                
                [userInfoModel setValue:value forKey:key];
                
            }
            @catch (NSException *exception) {
                DDLogError(@"exception:%@",exception);
            }
            @finally {
                
            }
        }
    } else {
        userInfoModel = [[demoUserInfoModel alloc] init];
        [userInfoModel setValue:value forKey:key];
    }
    
    if (userInfoModel && [userInfoModel isKindOfClass:demoUserInfoModel.class]) {
        NSString *userInfoJSON = [userInfoModel yy_modelToJSONString];
        if (userInfoJSON && [StringUtil empty:userInfoJSON] == NO && [userInfoJSON isKindOfClass:NSString.class]) {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:userInfoJSON forKey:kUserInfoString];
            [ud synchronize];
        }
    }
}

/**
 清除用户信息缓存
 */
+ (void)cleanUserInfo{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:nil forKey:kUserInfoString];
    [ud synchronize];
}

@end
