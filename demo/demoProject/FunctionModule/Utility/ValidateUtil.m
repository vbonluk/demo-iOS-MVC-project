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
 *  File name       :      ValidateUtil.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


//  ValidateUtil.m
//  xfj
//
//  Created by dong on 13-7-26.
//  Copyright (c) 2013年 bjy. All rights reserved.
//

#import "ValidateUtil.h"
#import "StringUtil.h"

@implementation ValidateUtil

//手机号码
+ (BOOL)validateMobileNumberFormat :(NSString *)searchMobileNumber{
    if([StringUtil empty:searchMobileNumber]){
        return NO; 
    }
    NSError *err = nil;
    NSString *phoneRegex = @"^((1[0-9][0-9])|(853|852)|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSRegularExpression *phoneExp = [NSRegularExpression regularExpressionWithPattern:phoneRegex options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatchPhone = [phoneExp firstMatchInString:searchMobileNumber options:0 range:NSMakeRange(0, [searchMobileNumber length])];
    if(isMatchPhone) {
        //DDLogError(@"格式正确");
        return YES;
    }
    DDLogError(@"格式不正确");
    return NO;
}

//手机号码 支持港澳
+ (BOOL)validateMobileNumberFormat :(NSString *)searchMobileNumber areaCode:(NSString *)areaCode{
    if([StringUtil empty:searchMobileNumber]){
        return NO;
    }
    if([StringUtil empty:areaCode]){
        return NO;
    }
    NSError *err = nil;
    //支持港澳，大陆号码
    NSString *phoneRegex = @"";
    if ([areaCode isEqualToString:@"+86"]) {
        phoneRegex = @"^((1[0-9][0-9])|(853|852)|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";//大陆
    } else if ([areaCode isEqualToString:@"+852"]) {
        phoneRegex = @"^([5|6|8|9])\\d{7}$";//香港
    } else if ([areaCode isEqualToString:@"+853"]) {
        phoneRegex = @"6[0-9]{7}";//澳门
    }
    NSRegularExpression *phoneExp = [NSRegularExpression regularExpressionWithPattern:phoneRegex options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatchPhone = [phoneExp firstMatchInString:searchMobileNumber options:0 range:NSMakeRange(0, [searchMobileNumber length])];
    if(isMatchPhone) {
        //DDLogError(@"格式正确");
        return YES;
    }
    DDLogError(@"格式不正确");
    return NO;
}

//中文姓名
+ (BOOL)validateChineseName: (NSString *)name
{
    BOOL flag;
    if (name.length <= 0) {
        flag = NO;
        return flag;
    }
    //下面的2表示最少位数，10为最大位数。
    NSString *regex2 = @"[\u4E00-\u9FA5]{2,10}";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:name];
}

//身份证号
+ (BOOL) validateIDcardFormatNew: (NSString *)identityCard
{
    /*
     * 身份证15位编码规则：dddddd yymmdd xx p
     * dddddd：6位地区编码
     * yymmdd: 出生年(两位年)月日，如：910215
     * xx: 顺序编码，系统产生，无法确定
     * p: 性别，奇数为男，偶数为女
     *
     * 身份证18位编码规则：dddddd yyyymmdd xxx y
     * dddddd：6位地区编码
     * yyyymmdd: 出生年(四位年)月日，如：19910215
     * xxx：顺序编码，系统产生，无法确定，奇数为男，偶数为女
     * y: 校验码，该位数值可通过前17位计算获得
     *
     * 前17位号码加权因子为 Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ]
     * 验证位 Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ]
     * 如果验证码恰好是10，为了保证身份证是十八位，那么第十八位将用X来代替
     * 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 )
     * i为身份证号码1...17 位; Y_P为校验码Y所在校验码数组位置
     */
    return NO;
}

//身份证号
+ (BOOL)validateIDcardFormat :(NSString *)idCard{
    if (idCard.length == 0 || idCard == nil) {
        return NO;
    }
    //判断是否只是数字
    NSString *regex = @"[0-9]*[1-9][0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSString *checkNumber = [idCard substringToIndex:idCard.length - 1];
    if(![pred evaluateWithObject: checkNumber]){
        return NO;
    }
    
    //判断位数
    if ([idCard length] < 15 ||[idCard length] > 18) {
        
        return NO;
    }
    
    NSString *carid = idCard;
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:idCard];
    if ([idCard length] == 15) {
        
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
        
    }
    
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    
    if (![self areaCode:sProvince]) {
        
        return NO;
    }
    
    //判断年月日是否有效
    
    //年份
    int strYear = [[StringUtil getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[StringUtil getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[StringUtil getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    
    return YES;
}
//身份证号-港澳,目前港澳版不作号码的有效性检验，只做长度不少于5位的判断
+ (BOOL)validateHKIDcardFormat :(NSString *)idCard{
    if (idCard.length == 0 || idCard == nil) {
        return NO;
    }
    //判断是否只是数字
    NSString *regex = @"[0-9]*[1-9][0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSString *checkNumber = [idCard substringToIndex:idCard.length - 1];
    if(![pred evaluateWithObject: checkNumber]){
        return NO;
    }
    
    //判断位数
    if ([idCard length] < 5) {
        
        return NO;
    }
    return YES;
}

/*
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        
        return NO;
    }
    return YES;
}

//利用正则表达式验证EMAIL格式
+(BOOL)validateEmailFormat:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//验证字符串是否纯数字
+(BOOL)validateNumFormat:(NSString *)num {
    NSString *emailRegex = @"^[0-9]*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:num];
}

//2位小数点
+(BOOL)validate2Point:(NSString *)num {
    NSString *emailRegex = @"^([+]?\\d{1,16})(\\.\\d{1,2})?$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:num];
}

//是否只含有中文，纯中文
+(BOOL)validateChineseStr:(NSString *)str;{
    NSString *emailRegex = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}
//是否含有中文
+(BOOL)validateContainChineseStr:(NSString *)str;{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i]; if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    
    //九宫格 汉字 获取到的是圈123这样的
    //要可以输入
    if ([string isEqualToString:@"➋"]||[string isEqualToString:@"➌"]||[string isEqualToString:@"➍"]||[string isEqualToString:@"➎"]||[string isEqualToString:@"➏"]||[string isEqualToString:@"➐"]||[string isEqualToString:@"➑"]||[string isEqualToString:@"➒"]) {
        return returnValue;
    }
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar high = [substring characterAtIndex: 0];
        // Surrogate pair (U+1D000-1F9FF)
        if (0xD800 <= high && high <= 0xDBFF) {
            const unichar low = [substring characterAtIndex: 1];
            const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
            if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                returnValue = YES;
            }
            // Not surrogate pair (U+2100-27BF)
        } else {
            if (0x2100 <= high && high <= 0x27BF){
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}

@end
