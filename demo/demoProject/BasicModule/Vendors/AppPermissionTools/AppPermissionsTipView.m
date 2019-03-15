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
 *  File name       :      AppPermissionsTipView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


//  PositionFailureTipView.m
//  xfj
//
//  Created by Vbon on 2017/5/31.
//  Copyright © 2017年 bjy. All rights reserved.
//

#import "AppPermissionsTipView.h"

@implementation AppPermissionsTipView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _mainView.alpha = 0;
    _bgView.alpha = 0;
    
    __block typeof(self) blockSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        blockSelf.mainView.alpha = 1;
        blockSelf.bgView.alpha = 0.5;
    } completion:nil];
    
    UITapGestureRecognizer *tapBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goTapBgView)];
    [_bgView addGestureRecognizer:tapBack];
    
}

- (void)setAppPermissionType:(AppPermissionType)appPermissionType{
    _appPermissionType = appPermissionType;
    
    switch (_appPermissionType) {
        case AppPermissionType_Camera:
            {
                _tipTitleLabel.text = @"相机权限未开启";
                _contentLabel.text = @"请在手机[设置]-[隐私]中允许幸福家经纪人使用“相机”";
            }
            break;
        case AppPermissionType_PhotoAlbum:
        {
            _tipTitleLabel.text = @"照片权限未开启";
            _contentLabel.text = @"请在手机[设置]-[隐私]中允许幸福家经纪人使用“照片”";
        }
            break;
        case AppPermissionType_GPS:
        {
            _tipTitleLabel.text = @"定位权限未开启";
            _contentLabel.text = @"请在手机[设置]-[隐私]中允许幸福家经纪人使用“定位”";
        }
            break;
        case AppPermissionType_AddressBook:
        {
            _tipTitleLabel.text = @"通讯录权限未开启";
            _contentLabel.text = @"请在手机[设置]-[隐私]中允许幸福家经纪人使用“通讯录”";
        }
            break;
        case AppPermissionType_NetWorking:
        {
            _tipTitleLabel.text = @"蜂窝网络或无线局域网权限未开启";
            _contentLabel.text = @"请在手机[设置]-[幸福家经纪人]-[无线数据]中允许幸福家经纪人使用“蜂窝网络或无线局域网”";
        }
            break;
        
        default:
            break;
    }
}

- (void)goBack{
    __block typeof(self) blockSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        blockSelf.mainView.alpha = 0;
        blockSelf.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)goTapBgView{
    
    [self goBack];
}

- (IBAction)goCancel:(id)sender {
    [self goBack];
}

- (IBAction)goConfirm:(id)sender {
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
//        //跳转到定位权限页面
//        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }else {
//        //跳转到定位开关界面
//        NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
//        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }
    
    //跳转到定位权限页面
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if( [[UIApplication sharedApplication]canOpenURL:url] ) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end
