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
 *  File name       :      demoBaseService.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "demoBaseService.h"
#import "demoDefaultResponse.h"
#import "UIApplication+demoGetCurrentViewController.h"
#import "ValidateUtil.h"
#import "YTKBaseRequest+demoAnimatingAccessory.h"
#import "demoLoginViewController.h"
#import <SAMKeychain.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"

#import "demoDynamicRefreshViewController.h"

@interface demoBaseService ()<YTKRequestAccessory>

/** 类型可能为model，也可能为model的数组array **/
@property (nonatomic, strong, readwrite, nullable) id responseJSONModel;

@end

@implementation demoBaseService

#pragma mark - Lifecycle

/**
 初始化方法
 */
- (id)init{
    self = [super init];
    if (self) {
        if ([self isShowHUDInRequest]) {
            self.animatingText = @"加载中...";
        }
    }
    return self;
}

#pragma mark - Overwrite Super Class

/**
 YTKRequestSerializerTypeJSON 对应 序列化数据以json格式进行请求
 YTKRequestSerializerTypeHTTP 对应 序列化数据以二进制格式进行请求

 @return YTKRequestSerializerTypeJSON
 */
- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

/**
 设置header

 @return header的字典
 */
- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSString *token = @"";
    demoUserInfoModel *userInfo = [demoUserInfoManager getUserInfoModel];
    if ([StringUtil empty:userInfo.token] == NO) {
        token = userInfo.token;
    }
    return @{@"token" : token};
}

- (void)requestCompletePreprocessor {
    [super requestCompletePreprocessor];
    
}

/**
 请求成功
 */
- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    
    if (self.responseStatusCode == 200) {
        demoDefaultResponse *defaultResponse = [demoDefaultResponse yy_modelWithJSON:self.responseString];
        
        if (defaultResponse.resultCode != demoResultCode_SUCCESS && [self hidErrorHUD] == NO) {
            self.successCompletionBlock = nil;//置空回调
            UIViewController *currentVC = [[UIApplication sharedApplication] activityViewController];
            if ([currentVC isKindOfClass:[demoDynamicRefreshViewController class]]) {
                demoDynamicRefreshViewController *dy = (demoDynamicRefreshViewController *)currentVC;
                [dy.reFreshHeader endRefreshing];
                [dy.reFreshFooter endRefreshing];
            }
            NSString *tipStr = @"";
            switch (defaultResponse.resultCode) {
                case demoResultCode_FAIL:
                {
                    //服务器异常
                    if ([StringUtil empty:defaultResponse.content]) {
                        tipStr = @"服务器异常";
                    } else {
                        tipStr = defaultResponse.content;
                    }
                }
                    break;
                case demoResultCode_TIP_WARN:
                {
                    //逻辑错误
                    if ([StringUtil empty:defaultResponse.content]) {
                        tipStr = @"服务器逻辑错误";
                    } else {
                        tipStr = defaultResponse.content;
                    }
                }
                    break;
                case demoResultCode_NEED_LOGIN:
                {
                    //未登录
                    if ([StringUtil empty:defaultResponse.content]) {
                        tipStr = @"登录信息过期,请重新登录";
                    } else {
                        //hud.label.text = defaultResponse.content;
                        tipStr = @"登录信息过期,请重新登录";
                    }
                    demoUserInfoModel *infoModel = [demoUserInfoManager getUserInfoModel];
                    if ([StringUtil empty:infoModel.token]) {
                        tipStr = @"";
                    }
                    /** 清除极光推送的标记与别名 **/
                    [self apServiceSetLoginTag:@"unLogin" alias:@""];
                    /** 清除本地用户信息 **/
                    [demoUserInfoManager cleanUserInfo];
                    /** 去登录 **/
                    [self needLogin];
                }
                    break;
                case demoResultCode_PARAM_ERROR:
                {
                    //参数不正确
                    if ([StringUtil empty:defaultResponse.content]) {
                        tipStr = @"请求参数不正确";
                    } else {
                        tipStr = defaultResponse.content;
                    }
                }
                    break;
                    
                default:
                    break;
            }
            if ([StringUtil empty:tipStr] == NO) {
                MBProgressHUD *hud = [demoHudHelper showHudWithText:tipStr isStay:NO];
                DDLogError(@"\n**************************************\n*%@:\n*responseStatusCode：%ld\n*Header：%@\n*URL：%@\n**************************************",hud.label.text,(long)self.responseStatusCode,self.requestHeaderFieldValueDictionary,self.currentRequest.URL.absoluteString);
            }
            
            if ([currentVC isKindOfClass:[demoBaseViewController class]]) {
                demoBaseViewController *ba = (demoBaseViewController *)currentVC;
                [ba apiCallBackErrorWithResultCode:defaultResponse.resultCode api:self];
            }
        }else{
            /* demoResultCode_SUCCESS */
            [self JSONConvertModel];
        }
    } else {
        NSString *tipStr = @"";
        if(self.responseStatusCode == 401){
            /* Unauthorized */
            tipStr = @"登录信息过期,请重新登录";
        } else if(self.responseStatusCode == 403){
            /* Forbidden */
            tipStr = @"服务器已拒绝连接";
        } else if(self.responseStatusCode == 404){
            /* Not Found */
            tipStr = @"请求失败";
        } else{
            /* other */
            tipStr = @"未知错误";
        }
        MBProgressHUD *hud = [demoHudHelper showHudWithText:tipStr isStay:NO];
        DDLogError(@"\n**************************************\n*%@:\n*responseStatusCode：%ld\n*Header：%@\n*URL：%@\n**************************************",hud.label.text,self.responseStatusCode,self.requestHeaderFieldValueDictionary,self.currentRequest.URL.absoluteString);
    }
}

- (void)requestFailedPreprocessor {
    [super requestFailedPreprocessor];
}

/**
 请求失败
 */
- (void)requestFailedFilter {
    [super requestFailedFilter];
    
    MBProgressHUD *hud = [demoHudHelper showHudWithText:@"请求失败，服务器已断开连接" isStay:NO];
    DDLogError(@"\n**************************************\n*%@:\n*responseStatusCode：%ld\n*Header：%@\n*URL：%@\n**************************************",hud.label.text,self.responseStatusCode,self.requestHeaderFieldValueDictionary,self.currentRequest.URL.absoluteString);
    
    UIViewController *currentVC = [[UIApplication sharedApplication] activityViewController];
    if ([currentVC isKindOfClass:[demoDynamicRefreshViewController class]]) {
        demoDynamicRefreshViewController *dy = (demoDynamicRefreshViewController *)currentVC;
        [dy.reFreshHeader endRefreshing];
        [dy.reFreshFooter endRefreshing];
    }
}

#pragma mark - Response Mehtods



#pragma mark - Delegate



#pragma mark - Private Methods

/**
 json转model的具体方法
 */
- (void)JSONConvertModel{
    Class modelClass = [self modelClass];
    if (!modelClass) {
        return;
    }
    demoDefaultResponse *defaultResponse = [demoDefaultResponse yy_modelWithJSON:self.responseString];
    
    id extend = defaultResponse.extend;
    if ([extend isKindOfClass:[NSDictionary class]]) {
        self.responseJSONModel = [modelClass yy_modelWithDictionary:(NSDictionary *)extend];
    } else if ([extend isKindOfClass:[NSArray class]]) {
        /** 处理 extend 首层为数组等的情况 **/
        /** 此时的responseJSONModel为数组 **/
        self.responseJSONModel = [NSArray yy_modelArrayWithClass:modelClass json:extend];
        if (self.responseJSONModel == nil) {
            DDLogError(@"model list 转换出错！");
        }
    }
    
    //    if (defaultResponse.resultCode == demoResultCode_SUCCESS) {
    //        /* 提取extend数据 */
    //        self.responseJSONModel = [modelClass yy_modelWithDictionary:defaultResponse.extend];
    //    }else{
    //        /* 请求成功但是没有拿到数据。*/
    //        self.responseJSONModel = [[modelClass alloc] init];
    //    }
}

/**
 是否隐藏错误弹框，子类可以重载
 
 @return YES为隐藏，NO为不隐藏，默认不隐藏
 */
- (BOOL)hidErrorHUD{
    return NO;
}

/**
 请求的时候是否持续显示HUD加载中
 
 @return YES为显示，NO为不显示，默认显示
 */
- (BOOL)isShowHUDInRequest{
    return YES;
}

/**
 登录
 */
- (void)needLogin{
    
    UIViewController *currentVC = [[UIApplication sharedApplication] activityViewController];
    
    if ([currentVC isKindOfClass:[demoLoginViewController class]] == NO) {
        demoLoginViewController *login = [[demoLoginViewController alloc] init];
        [login setLoginSuccessBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                /** 刷新当前页面 **/
                if ([currentVC isKindOfClass:demoBaseViewController.class]) {
                    demoBaseViewController *base = (demoBaseViewController *)currentVC;
                    [base reloadPage];
                }
                
                /** 刷新底部栏页面 **/
                UITabBarController *tabBar = APPDELEGATE.tabBarController;
                for (UINavigationController *nav in tabBar.viewControllers) {
                    demoBaseViewController *base_root = (demoBaseViewController *)nav.viewControllers[0];
                    [base_root reloadPage];
                }
            });
        }];
        login.hidesBottomBarWhenPushed = YES;
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:login];
        [currentVC.navigationController presentViewController:loginNav animated:YES completion:nil];
    }
}

/**
 每次调用 CFUUIDCreate 系统都会返回一个全新的唯一 ID. 如果想永久保存这个 ID，需要自己处理，可以一次获取后，存在 NSUserDefaults，Keychain，Pasteboard 等，下次再从这其中取出。
 
 @return uuid
 */
- (NSString *)getDeviceId{
    NSString *service = @"com.bazhua.agent";
    NSString *account = @"bzjj";
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:service account:account];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SAMKeychain setPassword:currentDeviceUUIDStr forService:service account:account];
    }
    return currentDeviceUUIDStr;
}
/**
 *  删除uuid
 */
- (void)deleteDeviceId{
    NSString *service = @"com.bazhua.agent";
    NSString *account = @"bzjj";
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:service account:account];
    if (currentDeviceUUIDStr != nil && ![currentDeviceUUIDStr isEqualToString:@""])
    {
        [SAMKeychain deletePasswordForService:service account:account];
    }
}

/**
 设置极光推送的标签已经别名
 
 @param tagLogin 标签
 @param alias 别名
 */
- (void)apServiceSetLoginTag:(NSString *)tagLogin alias:(NSString*)alias{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //appVersion = @"2.3.1.2";
    NSString *tagAppVersion = [NSString stringWithFormat:@"version_%@", [appVersion stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    NSSet *apnTags;
    apnTags = [NSSet setWithObjects:tagLogin, tagAppVersion, nil];
    
    NSString *aliasStr = alias;
    aliasStr = [aliasStr stringByReplacingOccurrencesOfString:@" " withString:@""];//去除空格
    [JPUSHService setTags:apnTags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        DDLogDebug(@"设置JPUSH的iTags成功：%@",iTags);
    } seq:0];
    [JPUSHService setAlias:aliasStr completion:^(NSInteger iResCode, NSString *demolias, NSInteger seq) {
        DDLogDebug(@"设置JPUSH的Alias成功：%@",demolias);
    } seq:0];
}

#pragma mark - Public Methods
/**
 配置返回的实体
 
 @return model class
 */
- (Class)modelClass{
    return nil;
}

#pragma mark - Getters and Setters





@end
