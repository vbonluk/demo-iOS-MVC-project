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
 *  File name       :      NSString+demoImageUrlString.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


//  NSString+XFJ_imageUrlString.m
//  xfj
//
//  Created by Vbon on 2017/2/17.
//  Copyright © 2017年 bjy. All rights reserved.
//

#import "NSString+demoImageUrlString.h"
#import "StringUtil.h"

@implementation NSString (demoImageUrlString)

+ (NSString*)ia_imageUrlPath:(NSString*)urlPath{
    if ([StringUtil empty:urlPath]) {
        return @"";
    }
    NSInteger imageWidth = (NSInteger)[UIScreen mainScreen].bounds.size.width * 2;
    return [NSString ia_imageUrlPath:urlPath width:imageWidth];
}

+ (NSString*)ia_imageUrlPath:(NSString*)urlPath width:(NSInteger)imageWidth{
    if ([StringUtil empty:urlPath]) {
        return @"";
    }
    NSString *hdStr=[[[NSUserDefaults standardUserDefaults] objectForKey:@"HD"] description];
    if ([hdStr floatValue] == 0) {
        hdStr = @"1";
    }else if ([hdStr floatValue] < 1){
        hdStr = @"1";
    }
    if ([urlPath rangeOfString:@"https"].location != NSNotFound) {
        
    } else {
        if ([urlPath rangeOfString:@"http"].location != NSNotFound) {//将http路径换成https路径
            if ([urlPath rangeOfString:@"/uploads/"].location == NSNotFound) {
                return urlPath;
            }
            urlPath = [urlPath substringFromIndex:[urlPath rangeOfString:@"/uploads/"].location];
            urlPath = [NSString stringWithFormat:@"%@%@",URL_IMAGE_SERVER,urlPath];
        } else {
            urlPath = [NSString stringWithFormat:@"%@%@",URL_IMAGE_SERVER,urlPath];
        }
    }
    if ([urlPath rangeOfString:@"x-oss-process=image/resize"].location == NSNotFound) {
        NSInteger bie = [hdStr floatValue];
        if (bie < 1) {
            bie = 1;
        }
        NSString *fullPath = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_%ld",urlPath,(long)(imageWidth * bie)];
        return fullPath;
    } else {
        NSString *suffix = @"?x-oss-process=image/resize,w_";//图片尺寸后缀
        //获取url上面的尺寸
        NSString *imgUrlSize = [urlPath substringFromIndex:[urlPath rangeOfString:suffix].location+[urlPath rangeOfString:suffix].length];
        NSString *fullStr = [suffix stringByAppendingString:imgUrlSize];
        fullStr = [fullStr substringToIndex:fullStr.length];
        
        NSString *fullPath = [urlPath stringByReplacingOccurrencesOfString:fullStr withString:[NSString stringWithFormat:@"?x-oss-process=image/resize,w_%ld",(long)(imageWidth * [hdStr floatValue])]];
        
        return fullPath;
    }
}

+ (NSString*)ia_imageUrlFullSizePathWith:(NSString*)urlPath{
    if ([StringUtil empty:urlPath]) {
        return @"";
    }
    if ([urlPath rangeOfString:@"https"].location != NSNotFound) {
        
    } else {
        if ([urlPath rangeOfString:@"http"].location != NSNotFound) {//将http路径换成https路径
            if ([urlPath rangeOfString:@"/uploads/"].location == NSNotFound) {
                return urlPath;
            }
            urlPath = [urlPath substringFromIndex:[urlPath rangeOfString:@"/uploads/"].location];
            urlPath = [NSString stringWithFormat:@"%@%@",URL_IMAGE_SERVER,urlPath];
        } else {
            urlPath = [NSString stringWithFormat:@"%@%@",URL_IMAGE_SERVER,urlPath];
        }
    }
    if ([urlPath rangeOfString:@"x-oss-process=image/resize"].location == NSNotFound) {
        return urlPath;
    } else {
        NSString *suffix = @"?x-oss-process=image/resize,w_";//图片尺寸后缀
        
        NSRange range = [urlPath rangeOfString:suffix];
        
        NSString *fullSizePath =  [urlPath substringToIndex:range.location];
        
        return fullSizePath;
    }
}

@end
