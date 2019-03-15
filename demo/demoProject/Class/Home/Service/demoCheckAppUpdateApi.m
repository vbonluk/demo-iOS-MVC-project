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
 *  File name       :      demoCheckAppUpdateApi.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoCheckAppUpdateApi.h"
#import "demoCheckAppUpdateModel.h"

@interface demoCheckAppUpdateApi ()



@end

@implementation demoCheckAppUpdateApi {
    
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
    return @"/individual_agent/api_mobile/system/checkAppUpdate";
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
    //获得版本号：
//    NSString *curVersion =  [[UIDevice currentDevice] systemVersion];
//    //获得build号：
//    NSString *curBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
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
    return [demoCheckAppUpdateModel class];
}

- (BOOL)isShowHUDInRequest{
    return NO;
}

@end
