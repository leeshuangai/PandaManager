//
//  NSString+Category.m
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>


#define LENGTH_VERIFY_CODE          6


@implementation NSString (Category)

//是否是有效手机号
- (BOOL) isValidMobileNumber {
    NSString* const MOBILE = @"^[1-9][0-9]{10}$";

    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidVerifyCode {
    
    NSString* const VERIFYCODE = [NSString stringWithFormat:@"^d{%d}$", LENGTH_VERIFY_CODE];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VERIFYCODE];
    return [predicate evaluateWithObject:self];
}

//有效银行卡
- (BOOL) isValidBankCardNumber {
//    if (self.length == 12) {
//        return YES;
//    }else {
        //NSString* const BANKCARD = @"^[0-9]{16,19}$";
        NSString* const BANKCARD = @"^[0-9]{4，}$";//^[0-9]*$
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
        return [predicate evaluateWithObject:self];
//    }
   
}

//有效身份证
- (BOOL) isValidIdentityCard {
    NSString* const IDENTITY = @"([0-9]{17}([0-9]|X|x)$)";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}

//有效的港澳台回乡证
- (BOOL)isValidHKTWMCIdentityCode{
    NSString* const IDENTITY = @"^[A-Za-z0-9]{1,15}$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}

+ (NSString*) stringFormatCurrencyRoundWithInteger:(NSInteger)currency ; //整数钱加逗号
{
    if (currency <= 0 || !currency) {
        return @"0";
    }
    
    NSString* value = [NSString stringWithFormat:@"%ld", currency];
    if (value.length < 4) {
        return value;
    }
   
    
    NSMutableString* string     = [[NSMutableString alloc] init];
    
    NSInteger index = [value length] - 3;
    while (index > 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(index, 3)];
        [string insertString:subValue atIndex:0];
        [string insertString:@"," atIndex:0];
        
        index -= 3;
    }
    
    if (index <= 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(0, 3 + index)];
        [string insertString:subValue atIndex:0];
    }
    
    
    
    return string;
}
//钱转为2位小数(对第三位进行四舍伍入),并添加逗号
+ (NSString*) stringFormatCurrencyRoundWithDouble:(double)currency {
    NSString* value = [NSString stringWithFormat:@"%.02f", currency];
    BOOL isNegative = [value hasPrefix:@"-"];
    if (isNegative) {
        value = [value stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    NSMutableString* string     = [[NSMutableString alloc] init];
    [string appendString:[value substringFromIndex:[value length] - 3]];
    
    NSInteger index = [value length] - 6;
    while (index > 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(index, 3)];
        [string insertString:subValue atIndex:0];
        [string insertString:@"," atIndex:0];
        
        index -= 3;
    }
    
    if (index <= 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(0, 3 + index)];
        [string insertString:subValue atIndex:0];
    }
    
    if (isNegative) {
        string = [NSMutableString stringWithString:[NSString stringWithFormat:@"-%@", string]];
    }
    
    return string;
}


//钱转为2位小数(直接舍去第三位),并添加逗号
+ (NSString*) stringFormatCurrencyFloorWithDouble:(double)currency {
    NSMutableString *tempValue = [NSMutableString stringWithString:[NSString stringWithFormat:@"%.03f", currency]];
    [tempValue deleteCharactersInRange:NSMakeRange(tempValue.length-1, 1)];
    NSString* value = tempValue;
    BOOL isNegative = [value hasPrefix:@"-"];
    if (isNegative) {
        value = [value stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    NSMutableString* string     = [[NSMutableString alloc] init];
    [string appendString:[value substringFromIndex:[value length] - 3]];
    
    NSInteger index = [value length] - 6;
    while (index > 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(index, 3)];
        [string insertString:subValue atIndex:0];
        [string insertString:@"," atIndex:0];
        
        index -= 3;
    }
    
    if (index <= 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(0, 3 + index)];
        [string insertString:subValue atIndex:0];
    }
    
    if (isNegative) {
        string = [NSMutableString stringWithString:[NSString stringWithFormat:@"-%@", string]];
    }
    
    return string;
}

//钱转为4位小数(直接舍去第五位)
+ (NSString*) stringFormatFourNumberWithDouble:(double)currency {
   NSString *string =[NSString stringWithFormat:@"%.04f", currency];
   
    return string;
}
+ (NSString *)stringFormatCurrencyToIntegerWithDouble:(double)currency{
    NSString *string = [NSString stringFormatCurrencyRoundWithDouble:currency];
    string = [string componentsSeparatedByString:@"."].firstObject;
    
    return string;
}

+ (NSString*) stringFormatJPYCurrencyWithDouble:(double)currency {
    NSString* value = [NSString stringWithFormat:@"%.0f", currency];;
    
    
    NSMutableString* string     = [[NSMutableString alloc] init];
    
    NSInteger index = [value length] - 3;
    while (index > 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(index, 3)];
        [string insertString:subValue atIndex:0];
        [string insertString:@"," atIndex:0];
        
        index -= 3;
    }
    
    if (index <= 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(0, 3 + index)];
        [string insertString:subValue atIndex:0];
    }
    
    return string;
}


- (BOOL)isBlankString{
    
    if (self == nil) {
        return YES;
    }
    if (self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}



- (NSString*) toBankStyleString {
    NSString *cardNum = [self removeWhiteSpace];
    if (cardNum.length == 0) {
        return @"";
    }
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i<cardNum.length; i++) {
        unichar c = [cardNum characterAtIndex:i];
        NSString *cString = [NSString stringWithCharacters:&c length:1];
        [result appendString:cString];
        if ((i+1) % 4 == 0) {
            if (i != result.length) {
                [result appendString:@" "];
            }
        }
    }
    return result;
}
- (NSString*) hidenIDCardStyleString {
    
    if (self.length == 0) {
        return @"";
    }
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i<self.length; i++) {
        unichar c = [self characterAtIndex:i];
        NSString *cString = [NSString stringWithCharacters:&c length:1];
      
        if (i > 2 && i< self.length-3) {
            [result appendString:@"*"];
        }else {
            [result appendString:cString];
        }
    }
    return result;
    
    
}


- (NSString*) removeWhiteSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL) isValidEmailAddress {
    
    if ([self rangeOfString:@"@"].length > 0)  {
        if ([self rangeOfString:@"."].length > 0) {
            return YES;
        }
    }
    return NO;
}

- (BOOL) isValidChinese {
   
    NSString* const IDENTITY = @"^[\u4e00-\u9fa5]*$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isName {
    
    
    NSString* const NAME = @"^[\u4e00-\u9fa5]*$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NAME];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidZip {
    NSString* const IDENTITY = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}


- (BOOL) hasExistedSpace {
    return ([self rangeOfString:@" "].length > 0);
}

- (BOOL) isValidAmount {
    NSString* const IDENTITY = @"^(([1-9]\\d{0,9})|0)(\\.\\d{0,2})?$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}

@end



@implementation NSString (urlEncode)

- (NSString *)URLEncodedChineseString {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLDecodedChineseString {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

@end



static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

@implementation NSString (Base64)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length {
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1) {
        return @"";
    }
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0) {
            break;
        }
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext) {
                input[i] = raw[ix];
            }
            else {
                input[i] = 0;
            }
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++) {
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        }
        
        for (i = ctcopy; i < 4; i++) {
            [result appendString: @"="];
        }
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length)) {
            charsonline = 0;
        }
    }     
    return result;
}

@end


@implementation NSString (Format)

- (NSString*)stringMobileFormat {
    
    if ([self isValidMobileNumber]) {
        NSMutableString* value = [[NSMutableString alloc] initWithString:self];
        [value insertString:@" " atIndex:3];
        [value insertString:@" " atIndex:8];
        return value;
    }
    
    return self;
}

- (NSString *)safeString {
    
    if (self.isNotBlank) {
        if ([self isEqualToString:@"null"] || [self isEqualToString:@"<null>"]|| [self isEqualToString:@"(null)"]  ){
            
            return @"";
        }else {
            return  self;
        }
    }
    return @"";
    
}
- (NSString *)safeStringFormart {
    
    if (self.isNotBlank) {
        return self;
    }else if ([self isEqualToString:@"null"]){
        return @"--";
    }
    else if ([self isEqualToString:@"<null>"]){
        return @"--";
    }
    else {
        return @"--";
    }
    
}
- (NSString *)stringByAppendingSafeString:(NSString *)appendingString {
    
    if (appendingString.isNotBlank) {
      return   [self stringByAppendingString:appendingString];
    }else {
        return self;
    }
}

+ (NSString*) stringChineseFormat:(double)value{
    
    if (value / 100000000.0f >= 1) {
        return [NSString stringWithFormat:@"%.2f亿", value / 100000000.0f];
    }
    else if (value / 10000.0f >= 1 && value / 100000000.0f < 1) {
        return [NSString stringWithFormat:@"%.2f万", value / 10000.0f];
    }
    else {
        return [NSString stringWithFormat:@"%.2f", value];
    }

}

- (NSString *)stringHidenMiddleMobile {
    
    if ([self checkPhoneNumber]) {
      NSString *numberString = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
       return  numberString;
    }else {
        return @"";
    }
    
}

+ (NSString*) stringFormatMillionUnitsWithInteger:(NSInteger)currency {
    
    return   [NSString stringWithFormat:@"%d", currency /10000];
    
}

+ (NSString *) stringFormatElementUnitsWithInteger:(NSInteger)currency {
    
    return   [NSString stringWithFormat:@"%d", currency * 10000];
}

- (NSString *)stringWebURLWithPara:(NSDictionary *)para {
    
    if ([para isKindOfClass:[NSDictionary class]]) {
        
        NSString *URLParameter;
        
        for (NSString *key in para) {
            
            if ([URLParameter isNotBlank]) {
                URLParameter = [URLParameter stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,para[key]]];
            }else{
                URLParameter = [NSString stringWithFormat:@"?%@=%@",key,para[key]];
            }
            
        }
        
        if ([URLParameter isNotBlank]) {
            return  [self stringByAppendingString:[URLParameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }else {
            return self;
        }
        
    }else {
        return self;
    }
    
    
    
}

- (NSString *)birthdayFormartFromIdentityCard {
    
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    
    NSString *day = nil;
   
    if([self length] <14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [self substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    
    if(!isAllNumber)
        return result;
    
    year = [self substringWithRange:NSMakeRange(6, 4)];
    month = [self substringWithRange:NSMakeRange(10, 2)];
    day = [self substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}


- (NSString *)filterBankBranchNameWithBankName:(NSString *)bankName {
    
    if (bankName.isNotBlank) {
        
        if ([self containsString:bankName]){
            
            return  [self stringByReplacingOccurrencesOfString:bankName withString:@""];
            
        }
        else {
           return self;
        }
       
    }else {
        
        return self;
        
    }
    
    
}
@end




@implementation NSString (MD5)

- (NSString*) md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],result[4],result[5],
            result[6],result[7],result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}

@end




@implementation NSString (UrlParameters)

- (NSDictionary*) parameters {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    NSArray* array          = [self componentsSeparatedByString:@"&"];
    
    [array enumerateObjectsUsingBlock:^(NSString*  _Nonnull value, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([value containsString:@"="]) {
            NSRange range = [value rangeOfString:@"="];
            NSString *key = [value substringWithRange:NSMakeRange(0, range.location)];
            NSString *val = [value substringWithRange:NSMakeRange(range.location+1, value.length - range.location - 1)];
            [parameters setObject:val forKey:key];
        }
    }];
    
    return parameters;
}

- (NSArray*) parametersSorted {
    NSMutableArray* parameters      = [NSMutableArray array];
    NSArray* array                  = [self componentsSeparatedByString:@"&"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* keyValues          = [(NSString*)obj componentsSeparatedByString:@"="];
        
        if (keyValues.count > 1) {
            [parameters addObject:@{keyValues[0]: keyValues[1]}];
        }
    }];
    
    return parameters;
}


- (NSDictionary*)jsonPatameters
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    NSArray* array          = [self componentsSeparatedByString:@"&"];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* keyValues  = [(NSString*)obj componentsSeparatedByString:@"="];
        NSString* string = keyValues[1];
        string = [string stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
        
        NSArray* arr = [string componentsSeparatedByString:@"\""];
        __block NSMutableArray* mutArr = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* str = (NSString*)obj;
            if ([str containsString:@"http"]) {
                [mutArr addObject:str];
            };
        }];
        [parameters setObject:mutArr forKey:keyValues[0]];
    }];
    
    return parameters;
}

@end




@implementation NSString (Date)
+ (NSString*) stringFromDate:(NSDate*)date {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString* string = [formatter stringFromDate:date];
    
    return string;
}
+ (NSString*) stringFromDate:(NSDate*)date formart:(NSString *)formart {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formart];
    
    NSString* string = [formatter stringFromDate:date];
    
    return string;
    
}
- (NSInteger)birthStringFromDate {
    return  [self birthStringFromDateFormart:@""];
}
- (NSInteger)birthStringFromDateFormart:(NSString *)dateFormart   {
  NSString *birth = self;
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    if (!dateFormart.isNotBlank) {
        dateFormart = @"yyyy年MM月dd日";
    }
     [dateFormatter setDateFormat:dateFormart];
//生日
NSDate *birthDay = [dateFormatter dateFromString:birth];
//当前时间
NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
//NSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
int age = ((int)time)/(3600*24*365);
//NSLog(@"year %d",age);
    return age;
}

- (BOOL)calculateCurrentDateHowMonths:(NSInteger)month {
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日";
    NSDate *endDates = [dateFormatter dateFromString:self];
    //起始日期与截止日期间隔不能大于2个月
    if ([[[NSDate date] dateByAddingTimeInterval:month*30*24*60*60] compare:endDates] == NSOrderedAscending) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)checkTodayWithFormart:(NSString *)formart {
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
      [format setDateFormat:formart.isNotBlank?formart:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:self];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
  
    
    return isToday;
}

- (BOOL)checkToday {
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:self];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];

    return isToday;
}
- (BOOL)checkTomorrowWithFormart:(NSString *)formart {
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:formart.isNotBlank?formart:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:self];
    BOOL isTomorrow = [[NSCalendar currentCalendar] isDateInTomorrow:date];
    
    
    return isTomorrow;
}

- (BOOL)checkTomorrow {
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:self];
    BOOL isTomorrow  = [[NSCalendar currentCalendar] isDateInTomorrow:date];
    
    return isTomorrow;
}

- (NSString*) stringFromWeekDay {
    
    NSString *weekDayStr = nil;

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    if(self.length>=10) {
        NSString *nowString = [self substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if(array.count==0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        
        if(array.count>=3) {
            NSInteger year = [[array objectAtIndex:0] integerValue];
            NSInteger month = [[array objectAtIndex:1] integerValue];
            NSInteger day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获取传入date
    NSDate *_date = [gregorian dateFromComponents:comps];
    
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    switch(week) {
        case 1:
            weekDayStr =@"星期日";
            break;
        case 2:
            weekDayStr =@"星期一";
            break;
        case 3:
            weekDayStr =@"星期二";
            break;
        case 4:
            weekDayStr =@"星期三";
            break;
        case 5:
            weekDayStr =@"星期四";
            break;
        case 6:
            weekDayStr =@"星期五";
            break;
        case 7:
            weekDayStr =@"星期六";
            break;
        default:
            weekDayStr =@"";
            break;
    }
    return weekDayStr;
}
+ (NSString *)getNumberOfDaysInMonthWithDate:(NSDate *)date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDate * currentDate = date;
    // 只要个时间给日历,就会帮你计算出来。这里的时间取当前的时间。
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:currentDate];
    return [NSString stringWithFormat:@"%ld",range.length];
}

@end




