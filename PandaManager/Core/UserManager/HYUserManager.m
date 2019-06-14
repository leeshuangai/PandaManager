//
//  LLUserManager.m
//  YQD
//
//  Created by lish on 2018/9/18.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "HYUserManager.h"
#import "NSFileManager+Category.h"


@implementation HYUserManager


+ (instancetype)shareInstance {
    
        static dispatch_once_t once;
        static id __singleton__;
        dispatch_once( &once, ^{
            __singleton__ = [[self alloc] init];
            
        } );
    
    return __singleton__;
    
}


/**
 用户登录userID
 
 
 @param userID userID description
 */
- (void)loginWithUserID:(NSString *)userID  password:(NSString *)password {
    
    HYUser *user = [[HYUser alloc]init];
    if ([self getUserInforWithUserId:userID]) {
        user = [self getUserInforWithUserId:userID];
    }
    user.userId = userID;
    user.password = password;
    self.currentUser = user;
    [self saveUserInfo:user completed:nil];
   
    
}

/**
 用户登出
 */
- (void)userLogout {
    
    self.currentUser = nil;
    
}



/**
 保存用户信息到本地
 
 @param dataModel dataModel description
 @param block block description
 */
- (void)saveUserInfo:(HYUser *)dataModel completed:(void(^)(BOOL completed))block {
    
    BOOL success = false;
    
    if (dataModel) {
        
        self.currentUser = dataModel;
        
        success =  [NSFileManager saveModelObject:dataModel fileName:[self userFileNameWithUserId:self.currentUser.userId]];
    }
    if (block) {
        block(success);
    }
    
}




/**
 从本地获取用户信息

 @param userId userid
 @return return value description
 */
- (HYUser *)getUserInforWithUserId:(NSString *)userId {
    
  return  [NSFileManager getModelObjectByFileName:[self userFileNameWithUserId:userId]];
    
}


#pragma mark private
- (NSString *)userFileNameWithUserId:(NSString *)userId {
    return [NSString stringWithFormat:@"%@_%@",@"userdata",userId];
}

- (NSString *)userFilePath {
    return [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:@"userdata"];
}


@end
