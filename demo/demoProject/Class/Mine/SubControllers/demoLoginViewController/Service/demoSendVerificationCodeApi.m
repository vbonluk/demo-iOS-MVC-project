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
 *  File name       :      demoSendVerificationCodeApi.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoSendVerificationCodeApi.h"
#import "demoVerificationCodeModel.h"

@interface demoSendVerificationCodeApi ()



@end

@implementation demoSendVerificationCodeApi {
    NSString *_phoneAreaCode;
    NSString *_phoneNumber;
}

/**
 初始化方法
 */
- (id)initWithPhoneAreaCode:(NSString *)phoneAreaCode phoneNumber:(NSString *)phoneNumber{
    self = [super init];
    if (self) {
        _phoneAreaCode = phoneAreaCode;
        _phoneNumber = phoneNumber;
    }
    return self;
}

/**
 配置请求路径

 @return url path
 */
- (NSString *)requestUrl {
    return @"/individual_agent/api_mobile/user/sendSms";
}

/**
 配置请求方法

 @return GET or POST
 */
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

/**
 配置请求参数(url)

 @return <#return value description#>
 */
- (id)requestArgument {
    NSString *senderDeviceId = [self getDeviceId];
    return @{@"phoneAreaCode":_phoneAreaCode,@"phoneNumber":_phoneNumber,@"sendLevel":@(0),@"sendSource":@"api",@"senderDeviceId":senderDeviceId,@"senderIp":@""};
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
    return [demoVerificationCodeModel class];
}

@end
