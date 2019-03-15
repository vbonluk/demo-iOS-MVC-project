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
 *  File name       :      demoBaseService.h
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import <Foundation/Foundation.h>
#import <YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface demoBaseService : YTKRequest

@property (nonatomic, strong, readonly, nullable) id responseJSONModel;

/**
 model对应的类，子类实现的话会直接映射到该model类并进行初始化操作

 @return model
 */
- (Class)modelClass;

/**
 是否隐藏错误弹框，子类可以重载
 
 @return YES为隐藏，NO为不隐藏，默认不隐藏
 */
- (BOOL)hidErrorHUD;

/**
 请求的时候是否持续显示HUD加载中

 @return YES为显示，NO为不显示，默认显示
 */
- (BOOL)isShowHUDInRequest;

/**
 每次调用 CFUUIDCreate 系统都会返回一个全新的唯一 ID. 如果想永久保存这个 ID，需要自己处理，可以一次获取后，存在 NSUserDefaults，Keychain，Pasteboard 等，下次再从这其中取出。
 
 @return uuid
 */
- (NSString *)getDeviceId;

/**
 设置极光推送的标签已经别名

 @param tagLogin 标签
 @param alias 别名
 */
- (void)apServiceSetLoginTag:(NSString *)tagLogin alias:(NSString*)alias;

@end

NS_ASSUME_NONNULL_END
