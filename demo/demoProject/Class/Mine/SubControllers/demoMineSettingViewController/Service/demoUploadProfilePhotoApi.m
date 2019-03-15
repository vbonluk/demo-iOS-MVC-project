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
 *  File name       :      demoUploadProfilePhotoApi.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoUploadProfilePhotoApi.h"

@interface demoUploadProfilePhotoApi ()

@property (strong, nonatomic) UIImage *img;

@end

@implementation demoUploadProfilePhotoApi {
    
}

/**
 初始化方法
 */
- (id)initWithImage:(UIImage *)image{
    self = [super init];
    if (self) {
        _img = image;
    }
    return self;
}

/**
 配置请求路径

 @return url path
 */
- (NSString *)requestUrl {
    return @"/individual_agent/api_mobile/user/saveUserAvatar";
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
//- (id)requestArgument {
//    return @{@"<#param#>":_<#param#>};
//}

/**
 配置请求参数(header)

 @return request header
 */
- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSDictionary *superHeader = [super requestHeaderFieldValueDictionary];
    NSMutableDictionary *headerDictionary = [NSMutableDictionary dictionaryWithDictionary:superHeader];
    return headerDictionary;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = [self compressQualityWithMaxLength:1024*1024];
        NSString *name = @"image";
        NSString *formKey = @"file";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self.img, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self.img, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}

@end
