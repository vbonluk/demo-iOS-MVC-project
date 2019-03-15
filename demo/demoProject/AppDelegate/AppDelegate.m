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
 *  File name       :      AppDelegate.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


//  AppDelegate.m
//  demoProject
//
//  Created by Vbon on 2018/12/27.
//  Copyright © 2018 xfj. All rights reserved.
//

#import "AppDelegate.h"
#import "demoHomeViewController.h"
#import "demoUrlArgumentsFilter.h"
#import "demoNavigationController.h"
#import "demoMineViewController.h"
#import <IQKeyboardManager.h>
#import "ZYNetworkAccessibity.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

// 引入JAnalytics功能所需头文件
#import "JANALYTICSService.h"

#ifdef ISDEBUG
#if ISDEBUG == 1
#import "YYFPSLabel.h"
#endif
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@property (strong, nonatomic, readwrite) UITabBarController *tabBarController;

@end

@implementation AppDelegate

#pragma mark - Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [ZYNetworkAccessibity setAlertEnable:YES];
    
    [ZYNetworkAccessibity setStateDidUpdateNotifier:^(ZYNetworkAccessibleState state) {
        if (state == ZYNetworkRestricted) {
            //NSLog(@"网络权限被关闭");
        }
    }];
    
    [ZYNetworkAccessibity start];
    
    [self ia_configAppWindow];
    
    [self configFrameworkWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    [self.window makeKeyAndVisible];
    
    #ifdef ISDEBUG
    #if ISDEBUG == 1
    [self showFpsLabel];
    #endif
    #endif
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    DDLogError(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
    
    // 设置Badge数量为0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
        //前台状态处理收到的消息
        
    }else{
        
    }
    
}
#pragma mark - jshare open url
//仅支持 iOS9 以上系统，iOS8 及以下系统不会回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    [JSHAREService handleOpenUrl:url];
    return YES;
}

#pragma mark - Private Methods

/**
 * 初始化视窗
 */
- (void)ia_configAppWindow{
    
    // 首页
    demoHomeViewController *homeVC = [[demoHomeViewController alloc] init];
    homeVC.title = @"首页";
    demoNavigationController *homeNav = [[demoNavigationController alloc] initWithRootViewController:homeVC];
    
    UIImage *home_img=[UIImage imageNamed:@"tabBarItem_1"];
    UIImage *home_img_hl=[UIImage imageNamed:@"tabBarItem_hl_1"];
    
    homeVC.tabBarItem.image = [home_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.selectedImage = [home_img_hl imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    // 我的
    demoMineViewController *mineVC = [[demoMineViewController alloc] init];
    mineVC.title = @"我的";
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];

    UIImage *mine_img=[UIImage imageNamed:@"tabBarItem_3"];
    UIImage *mine_img_hl=[UIImage imageNamed:@"tabBarItem_hl_3"];

    mineVC.tabBarItem.image = [mine_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineVC.tabBarItem.selectedImage = [mine_img_hl imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[homeNav,mineNav];
    
    UIFont *itemFont = kIAFontSmall;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : HEXCOLOR(0xb0b0b0),NSFontAttributeName:itemFont} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : HEXCOLOR(0x996C33),NSFontAttributeName:itemFont} forState:UIControlStateSelected];
    
    self.window.rootViewController = tabBarController;
}

/**
 配置第三方库

 @param application <#application description#>
 @param launchOptions <#launchOptions description#>
 */
- (void)configFrameworkWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /* YTKNetwork */
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    config.baseUrl = @"";
    //config.cdnUrl = @"http://";
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = APP_TRUE_SERVER_URL;
    
//    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //获得版本号：
    NSString *curVersion =  [[UIDevice currentDevice] systemVersion];
    NSString *curVersion_num = [NSString stringWithFormat:@"%d",[curVersion intValue]];
    //获得build号：
    NSString *curBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    demoUrlArgumentsFilter *urlFilter = [demoUrlArgumentsFilter filterWithArguments:@{@"version" : curVersion_num, @"appVersionCode":curBuild,@"type":@"ios"}];
    [config addUrlFilter:urlFilter];
    
    /* CocoaLumberjack */
    [DDLog addLogger:[DDTTYLogger sharedInstance]];             // TTY = Xcode console
//    [DDLog addLogger:[DDASLLogger sharedInstance]];             // ASL = Apple System Logs
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];     // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24;                 // 刷新频率为24小时
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;      // 最大文件数量为7个
    [DDLog addLogger:fileLogger];
    
    /** 极光推送 **/
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:@""
                          channel:@"app store"
                 apsForProduction:FALSE
            advertisingIdentifier:nil];
    /** 极光统计 **/
    JANALYTICSLaunchConfig *config_tongji = [[JANALYTICSLaunchConfig alloc] init];
    config_tongji.appKey = @"";
    config_tongji.channel = @"app store";
    [JANALYTICSService setupWithConfig:config_tongji];
    /** 极光分享 **/
    JSHARELaunchConfig *config_share = [[JSHARELaunchConfig alloc] init];
    config_share.isProduction = YES;
    config_share.appKey = @"";
    config_share.SinaWeiboAppKey = @"";
    config_share.SinaWeiboAppSecret = @"";
    config_share.SinaRedirectUri = @"http://";
    config_share.QQAppId = @"";
    config_share.QQAppKey = @"";
    config_share.WeChatAppId = @"";
    config_share.WeChatAppSecret = @"";
    [JSHAREService setupWithConfig:config_share];
    [JSHAREService setDebug:ISDEBUG];
    
    /** IQKeyboardManager **/
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    
    /** 百度地图配置 **/
    //百度地图相关配置已被集成到工具类：demoLocationManager.h
    
}

#ifdef ISDEBUG
#if ISDEBUG == 1
/**
 显示性能检测工具，数据仅供参考，不一定准确。准确的请使用Xcode的工具测量
 */
- (void)showFpsLabel{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in keyWindow.subviews) {
        if ([view isKindOfClass:[YYFPSLabel class]]) {
            [view removeFromSuperview];
        }
    }
    YYFPSLabel *fpsLabel = [YYFPSLabel new];
    fpsLabel.frame = CGRectMake(0, 2, 50, 30);
    fpsLabel.center = CGPointMake(keyWindow.center.x + 55, fpsLabel.center.y);
    [fpsLabel sizeToFit];
    [keyWindow addSubview:fpsLabel];
    [keyWindow bringSubviewToFront:fpsLabel];
}
#endif
#endif

#pragma mark - Public Methods



@end
