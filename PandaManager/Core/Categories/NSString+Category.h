//
//  NSString+Category.h
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

- (BOOL) isValidMobileNumber;
- (BOOL) isValidVerifyCode;
- (BOOL) isValidBankCardNumber;
- (BOOL) isValidIdentityCard;
- (BOOL) isValidHKTWMCIdentityCode;//有效的港澳台回乡证
- (BOOL) isValidEmailAddress;
- (BOOL) isValidChinese;
- (BOOL) isName;
- (BOOL) isValidZip;
- (BOOL) hasExistedSpace;
- (BOOL) isValidAmount;


/**
 返回以万为单位的字符串

 @param currency jine
 @return return value description
 */
+ (NSString*) stringFormatMillionUnitsWithInteger:(NSInteger)currency;

/**
 万单位返回以元为单位字符串
 
 @param currency 金额
 @return return value description
 */
+ (NSString *) stringFormatElementUnitsWithInteger:(NSInteger)currency;


/**
 整数钱加逗号

 @param currency 金额
 @return return value description
 */
+ (NSString*) stringFormatCurrencyRoundWithInteger:(NSInteger)currency ;


/**
 钱转为2位小数(直接舍去第三位),并添加逗号

 @param currency 金额
 @return return value description
 */
+ (NSString*) stringFormatCurrencyFloorWithDouble:(double)currency;


/**
 钱转为2位小数(对第三位进行四舍伍入),并添加逗号

 @param currency 金额
 @return return value description
 */
+ (NSString*) stringFormatCurrencyRoundWithDouble:(double)currency;


/**
 钱转为4位小数(直接舍去第五位)

 @param currency 金额
 @return return value description
 */
+ (NSString*) stringFormatFourNumberWithDouble:(double)currency;


/**
 转为带有逗号的整数字符串

 @param currency 金额
 @return return value description
 */
+ (NSString*) stringFormatCurrencyToIntegerWithDouble:(double)currency;


+ (NSString*) stringFormatJPYCurrencyWithDouble:(double)currency;


/**
 是不是空白字符串

 @return return value description
 */
- (BOOL)isBlankString;


/**
 *  银行卡每4位一个空白字符，显示样式
 *
 *  @return 银行卡每4位一个空白字符字符串
 */
- (NSString*) toBankStyleString;


/**
 身份证号隐藏中间字段

 @return return value description
 */
- (NSString*) hidenIDCardStyleString;
/**
 移除字符串的空白符号

 @return return value description
 */
- (NSString*) removeWhiteSpace;


@end


@interface NSString (urlEncode)
- (NSString *)URLEncodedString;
- (NSString *)URLEncodedChineseString;
- (NSString *)URLDecodedChineseString;
@end


@interface NSString (Base64)
+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;
@end


@interface NSString (MD5)
- (NSString*)md5String;
@end


@interface NSString (Format)

/**
 手机号码 344空白符号
 
 @return return value description
 */
- (NSString*)stringMobileFormat;

+ (NSString*)stringChineseFormat:(double)value;

- (NSString *)stringHidenMiddleMobile;

- (NSString *)safeString;

- (NSString *)safeStringFormart;

- (NSString *)stringByAppendingSafeString:(NSString *)appendingString;

- (NSString *)stringWebURLWithPara:(NSDictionary *)para;


//传身份证返回生日字符串
- (NSString *)birthdayFormartFromIdentityCard;


- (NSString *)filterBankBranchNameWithBankName:(NSString *)bankName;

@end


@interface NSString (UrlParameters)
- (NSDictionary*) parameters;
- (NSArray*) parametersSorted;
- (NSDictionary*)jsonPatameters;

@end


@interface NSString (Date)
+ (NSString*) stringFromDate:(NSDate*)date;
+ (NSString*) stringFromDate:(NSDate*)date formart:(NSString *)formart;
//判断年龄
- (NSInteger)birthStringFromDate;
- (NSInteger)birthStringFromDateFormart:(NSString *)dateFormart;
- (BOOL)calculateCurrentDateHowMonths:(NSInteger)month;
//根据日期 计算星期几
- (NSString*) stringFromWeekDay;
//是否为今天
- (BOOL)checkTodayFormart:(NSString *)formart;
- (BOOL)checkToday;
//是否为明天
- (BOOL)checkTomorrowWithFormart:(NSString *)formart;
- (BOOL)checkTomorrow;
+ (NSString *)getNumberOfDaysInMonthWithDate:(NSDate *)date;

    
@end





