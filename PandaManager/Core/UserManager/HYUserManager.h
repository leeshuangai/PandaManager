//
//  LLUserManager.h
//  YQD
//
//  Created by lish on 2018/9/18.
//  Copyright © 2018年 lish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYUser.h"

//static HYUser *        [HYUserManager shareInstance].currentUser = nil;

@interface HYUserManager : NSObject

@property (nonatomic,strong) HYUser * currentUser;

+ (instancetype)shareInstance;


/**
 保存用户用户userID
 

 @param userID userID description
 */
- (void)loginWithUserID:(NSString *)userID  password:(NSString *)password;


/**
 用户登出
 */
- (void)userLogout;


/**
 保存用户信息到本地
 
 @param dataModel dataModel description
 @param block block description
 */
- (void)saveUserInfo:(HYUser *)dataModel completed:(void(^)(BOOL completed))block;


/**
 获取用户数据

 @param userId userId
 */
- (HYUser *)getUserInforWithUserId:(NSString *)userId;



@end
