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
 *  File name       :      AppPermissionTools.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


//  AppPermissionTools.m
//  xfj
//
//  Created by Vbon on 2018/6/11.
//Copyright © 2018年 bjy. All rights reserved.
//

#import "AppPermissionTools.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <Photos/PHPhotoLibrary.h>
#import <AddressBook/AddressBook.h>
#import <ContactsUI/ContactsUI.h>
#import "RealReachability.h"
#import <CoreLocation/CLLocationManager.h>

static AppPermissionTools* _instance = nil;

@interface AppPermissionTools ()

@property (assign, nonatomic) AppPermissionType appPermissionType;

@end

@implementation AppPermissionTools

+ (instancetype) shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    }) ;
    
    return _instance ;
}

- (BOOL)CheckPermissionWithType:(AppPermissionType)appPermissionType{
    
    _appPermissionType = appPermissionType;
    
    //从后台返回app，通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:app];
    
    switch (appPermissionType) {
        case AppPermissionType_Camera:
        {
            return [self CheckCameraPermission];
        }
            break;
        case AppPermissionType_PhotoAlbum:
        {
            return [self CheckPhotoAlbumPermission];
        }
            break;
        case AppPermissionType_GPS:
        {
            return [self CheckGPSPermission];
        }
            break;
        case AppPermissionType_AddressBook:
        {
            return [self CheckAddressBookPermission];
        }
            break;
        case AppPermissionType_NetWorking:
        {
            return [self CheckNetWorkingPermission];
        }
            break;
            
        default:
            break;
    }
    
    return YES;
}

/**
 相机权限

 @return <#return value description#>
 */
- (BOOL)CheckCameraPermission{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        //无权限
        [self showTipView];
        return NO;
    }else{
        [self dismissTipView];
    }
    
    return YES;
}

/**
 相册权限

 @return <#return value description#>
 */
- (BOOL)CheckPhotoAlbumPermission{
    
    // 从相册中选取
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        //无权限
        [self showTipView];
        return NO;
    }else{
        [self dismissTipView];
    }
    
    return YES;
}

/**
 GPS权限

 @return <#return value description#>
 */
- (BOOL)CheckGPSPermission{
    
    //判断定位是否开启
    if ([CLLocationManager locationServicesEnabled]){
        //  判断用户是否允许程序获取位置权限
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways){
            //用户允许获取位置权限
            [self dismissTipView];
        }else{
            //用户拒绝开启用户权限
            [self showTipView];
            return NO;
        }
    }else{
        [self showTipView];
        return NO;
    }
    
    return YES;
}

/**
 通讯录权限

 @return <#return value description#>
 */
- (BOOL)CheckAddressBookPermission{
    
    if (__IPHONE_9_0) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusNotDetermined) {
            __block BOOL isAuthorization = NO;
            //发起请求权限
            [[[CNContactStore alloc]init] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if(granted){
                    //                    NSLog(@"点击了同意");
                    [self dismissTipView];
                    isAuthorization = YES;
                }else{
                    //                    NSLog(@"点击了拒绝");
                    [self showTipView];
                    isAuthorization = NO;
                }
            }];
            return isAuthorization;
        }else if (status == CNAuthorizationStatusAuthorized){
            [self dismissTipView];
        }else {
            //CNAuthorizationStatusDenied 拒绝
            //因为我们并不是读取用户所有通讯录，调用的是系统自带的UI，所以这里的权限不影响。返回YES。
            [self dismissTipView];
            return YES;
        }
    }else{
        /* ios 9 以下
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        
        if (authStatus != kABAuthorizationStatusAuthorized){
            __block BOOL isAuthorization = NO;
            //发起请求权限
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error){
                        NSLog(@"Error: %@", (__bridge NSError *)error);
                    }
                    else if (!granted){
                        [self showTipView];
                        isAuthorization = NO;
                    }
                    else{
                        [self dismissTipView];
                        isAuthorization = YES;
                    }
                });
            });
            return isAuthorization;
        }else{
            [self dismissTipView];
        }
         */
    }
    
    return YES;
}

/**
 网络权限（不准确，iOS10之后国行机器出现网络权限）

 @return <#return value description#>
 */
- (BOOL)CheckNetWorkingPermission{
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    DDLogError(@"Initial reachability status:%@",@(status));
    
    if (status == RealStatusNotReachable){
        return NO;
    }
    
    return YES;
}

/**
 切换回app，回调

 @param notification <#notification description#>
 */
- (void)applicationWillEnterForeground:(NSNotification *)notification{
    BOOL isActivity = NO;
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 11223344) {
            isActivity = YES;
        }
    }
    if (isActivity == YES) {
        [self CheckPermissionWithType:_appPermissionType];
    }
    
    if (_applicationWillEnterForegroundNotification) {
        _applicationWillEnterForegroundNotification();
    }
}

- (void)showTipView{
    AppPermissionsTipView *position = [[[NSBundle mainBundle] loadNibNamed:@"AppPermissionsTipView" owner:self options:nil] firstObject];
    position.frame = [UIScreen mainScreen].bounds;
    position.appPermissionType = _appPermissionType;
    position.tag = 11223344;
    BOOL isActivity = NO;
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 11223344) {
            isActivity = YES;
        }
    }
    if (isActivity == NO) {
        [[UIApplication sharedApplication].keyWindow addSubview:position];
    }
}

- (void)dismissTipView{
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 11223344) {
            AppPermissionsTipView *position = (AppPermissionsTipView *)view;
            [position goCancel:nil];
        }
    }
}

@end
