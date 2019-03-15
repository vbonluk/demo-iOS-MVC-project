//
//  StringUtil.m
//  xfj
//
//  Created by dong on 13-6-27.
//  Copyright (c) 2013年 bjy. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil
+ (BOOL) empty:(id)tempObj{
    if (([tempObj isKindOfClass:[NSNull class]])||
        (tempObj == nil) ||
        (tempObj == (id)[NSNull null])||
        [tempObj isEqual:[NSNull null]] ||
        [tempObj isEqual:nil]) {
    }
    else {
        if([tempObj respondsToSelector:@selector(isEqualToString:)]) {
            if ([tempObj isEqualToString:@"<null>"] ||
                [tempObj isEqualToString:@"(null)"]) {
            }
            else {
                if ([tempObj respondsToSelector:@selector(length)]) {
                    if ([tempObj length]>0) {
//                        NSLog(@"Check Passed.");
                        return NO;
                    }
                }
            }
        }
    }
    return YES;
}

+ (BOOL) isContains:(NSString *)fatherString subString:(NSString *)subString{
    if([fatherString rangeOfString:subString].location != NSNotFound){
        return YES;
    }else{
        return NO;
    }
}


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
 *  File name       :      StringUtil.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSUInteger )value1 Value2:(NSUInteger )value2
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}


+(NSString *)formatDoublePrice:(double)price
{
    return  [self formatDoublePrice:(double)price  format:@"%.1f"];
   
}

+(NSString *)formatDoublePrice:(double)price  format:(NSString *)format
{
    NSString *priceString = [NSString stringWithFormat:format, price];
    if([self isContains:priceString subString:@".0"]){
        return [NSString stringWithFormat:@"%.0f", price];
    }
    return [NSString stringWithFormat:format, price];
}

+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    
    // trim off whitespace
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
    
}

+ (NSString *)formatPhoneNumberBySpace:(NSString*)phoneNumber{
    if([self empty:phoneNumber]){
        return phoneNumber;
    }else{
        if(phoneNumber.length >=13){
            if([phoneNumber hasPrefix:@"86"]){
                phoneNumber = [phoneNumber substringFromIndex:2];
            }
            if([phoneNumber hasPrefix:@"+86"]){
                phoneNumber = [phoneNumber substringFromIndex:3];
            }
        }
        if ([phoneNumber rangeOfString:@"-"].location != NSNotFound) {
            phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        if(phoneNumber.length == 11){
            if ([phoneNumber characterAtIndex:0] == '1') {
                return [NSString stringWithFormat:@"%@ %@ %@", [phoneNumber substringWithRange:NSMakeRange(0, 3)],[phoneNumber substringWithRange:NSMakeRange(3, 4)], [phoneNumber substringWithRange:NSMakeRange(7, 4)]];
            }else{
                return [NSString stringWithFormat:@"%@ %@", [phoneNumber substringWithRange:NSMakeRange(0, 4)],[phoneNumber substringWithRange:NSMakeRange(4, 7)]];
            }
        }
    }
    return phoneNumber;
}

//  将汉字转换为不带音调的拼音

+ (NSString *)transformMandarinToLatin:(NSString *)string

{
    NSMutableString *preString = [string mutableCopy];
    
    /*转换成成带音 调的拼音*/
    if( CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformMandarinLatin, NO)){}
    /*去掉音调*/
    if(CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformStripDiacritics, NO)){}
    
    return preString;
}
@end
