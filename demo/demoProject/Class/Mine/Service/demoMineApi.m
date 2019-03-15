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
 *  File name       :      demoMineApi.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoMineApi.h"
#import "demoMineModel.h"

@interface demoMineApi ()



@end

@implementation demoMineApi {
    
}

/**
 初始化方法
 */
- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 配置请求路径

 @return url path
 */
- (NSString *)requestUrl {
    return @"/individual_agent/api_mobile/user/user";
}

/**
 配置请求方法

 @return GET or POST
 */
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

/**
 配置请求参数(url)

 @return <#return value description#>
 */
- (id)requestArgument {
    return @{};
}

/**
 配置请求参数(header)

 @return request header
 */
- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSDictionary *superHeader = [super requestHeaderFieldValueDictionary];
    NSMutableDictionary *headerDictionary = [NSMutableDictionary dictionaryWithDictionary:superHeader];
    return headerDictionary;
}

/**
 配置返回的实体

 @return model class
 */
- (Class)modelClass {
    return [demoMineModel class];
}

/**
 请求成功
 */
- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    
    /** 将存储用户信息的方法写在api的原因是方便管理，只要调用此api做更新，即可立即存储，不用另外补写逻辑 **/
    if (self.responseJSONModel && [self.responseJSONModel isKindOfClass:[demoMineModel class]]) {
        demoMineModel *m = self.responseJSONModel;
        // 存储用户info
        demoUserInfoModel *infoModel = [demoUserInfoManager getUserInfoModel];
        infoModel.userId = m.userId;
        infoModel.userAvatar = m.userAvatar;
        infoModel.userName = m.userName;
        infoModel.userPhone = m.userPhone;
        infoModel.userGender = m.userGender;
        infoModel.isAuthentication = m.isAuthentication;
        [demoUserInfoManager saveUserInfoModelWithModel:infoModel];
    }
}

@end
