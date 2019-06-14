//
//  HYCommonTip.h
//  TeamDevelop
//
//  Created by lish on 2019/6/5.
//  Copyright © 2019 develop. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYCommonTip : NSObject

/**
 用户注册

 @param userCode 用户注册的名字或手机号
 @param password 密码
 @param comfirmPassword 确认密码
 @return return value description
 */
+ (NSString *)hy_userRegisterWithUserCode:(NSString *)userCode password:(NSString *)password comfirmPassword:(NSString *)comfirmPassword;

/**
 用户登录

 @param userCode 用户登录名字或手机号
 @param password 用户登录密码
 @return return value description
 */
+ (NSString *)hy_userLoginWithUserCode:(NSString *)userCode password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
