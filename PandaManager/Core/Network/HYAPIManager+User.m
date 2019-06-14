//
//  HYAPIManager+User.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYAPIManager+User.h"

@implementation HYAPIManager (User)

- (void)queryUserLoginWithUserId:(NSString *)userId password:(NSString *)password  completion:(void(^)(BOOL success,id data,NSString *error))completion {
    
    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {

      
        
        if (success) {
            
            //先去查询数据账号
            HYUser *user =  [[HYUserManager shareInstance]getUserInforWithUserId:userId];
            if ((user || user.userId.isNotBlank) && [user.password isEqualToString:password]) {
               
                [[HYUserManager shareInstance]loginWithUserID:userId password:password];
                
                if (completion) {
                    completion(success, [HYUserManager shareInstance].currentUser,error);
                }
                
            }else {
                if (completion) {
                    completion(NO,data,@"用户名或密码错误");
                }
            }
        }
        else {
            if (completion) {
                completion(success,data,error);
            }
        }
        
    }];
}
- (void)queryUserLoginoutWithUserId:(NSString *)userId completion:(void(^)(BOOL success,id data,NSString *error))completion {
    
    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        
        if (success) {
            
            [[HYUserManager shareInstance]userLogout];
            
        }
        if (completion) {
            completion(success,data,error);
        }
        
    }];
}

- (void)queryUserRegisterWithUserId:(NSString *)userId password:(NSString *)password  completion:(void(^)(BOOL success,id data,NSString *error))completion {
    
    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        
        if (success) {
            
            //先去查询数据账号
            HYUser *user =  [[HYUserManager shareInstance]getUserInforWithUserId:userId];
            if (user || user.userId.isNotBlank) {
                
                if (completion) {
                    completion(NO,nil,@"账户已存在");
                }
                
            }else {
                [[HYUserManager shareInstance]loginWithUserID:userId password:password];
                if (completion) {
                    completion(success,data,error);
                }
            }
            
        }else {
            if (completion) {
                completion(success,data,error);
            }
        }
        
        
        
    }];
}

- (void)modifyUserInfoWithUserInfo:(HYUser *)user completion:(void(^)(BOOL success,id data,NSString *error))completion {
    
    
    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        
        if (success) {
            
            [[HYUserManager shareInstance]saveUserInfo:user completed:nil];
            
            if (completion) {
                completion(success,        [HYUserManager shareInstance].currentUser,error);
            }
        }
        else {
            if (completion) {
                completion(success,data,error);
            }
        }
        
    }];
    
}

@end
