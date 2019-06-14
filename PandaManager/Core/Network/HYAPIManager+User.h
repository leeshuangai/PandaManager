//
//  HYAPIManager+User.h
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYAPIManager (User)

/**
 用户登录

 @param userId 用户id
 @param completion completion description
 */
- (void)queryUserLoginWithUserId:(NSString *)userId password:(NSString *)password completion:(void(^)(BOOL success,id data,NSString *error))completion;


/**
 用户登出

 @param userId 用户id
 @param completion completion description
 */
- (void)queryUserLoginoutWithUserId:(NSString *)userId completion:(void(^)(BOOL success,id data,NSString *error))completion ;


/**
 用户注册

 @param userId 用户id
 @param completion completion description
 */

- (void)queryUserRegisterWithUserId:(NSString *)userId password:(NSString *)password completion:(void(^)(BOOL success,id data,NSString *error))completion;


/**
 修改用户信息

 @param user user description
 @param completion completion description
 */
- (void)modifyUserInfoWithUserInfo:(HYUser *)user completion:(void(^)(BOOL success,id data,NSString *error))completion;


@end

NS_ASSUME_NONNULL_END
