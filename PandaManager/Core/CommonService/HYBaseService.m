//
//  HYBaseService.m
//  TeamDevelop
//
//  Created by lish on 2019/6/14.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYBaseService.h"
#import "HYLoginViewController.h"
@implementation HYBaseService

+ (void)userLoginHandleWithName:(NSString *)name password:(NSString *)password {
    [[NSObject getCurrentVC].view endEditing:YES];
    if (name.isNotBlank && password.isNotBlank) {
        
        
        [[HYAPIManager shareInstance]queryUserLoginWithUserId:name password:password
                                                   completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
                                                       
                                                       if (!success) {
                                                           [HYHUD showSuccessHUD:error];
                                                       }
                                                       else {
                                                           
                                                           [HYCommonService swicthTabRootController];
                                                           
                                                           [HYHUD showSuccessHUD:@"登录成功"];
                                                       }
                                                   }];
        
    }else {
        [HYHUD showSuccessHUD:@"请正确输入正确手机号或密码"];
    }
    
    
}

+ (void)userRegisterHandleWithName:(NSString *)name password:(NSString *)password commitPassword:(NSString *)commitPassword {
    
      [[NSObject getCurrentVC].view endEditing:YES];
    
    if (![name checkPhoneNumber]) {
        [HYHUD showSuccessHUD:@"请输入正确手机号"];
        return;
    }
    else if (![password isEqualToString:
              commitPassword]){
        
        [HYHUD showSuccessHUD:@"两次密码输入不相同"];
        return;
    }
    
    else if (password.length < 6){
        [HYHUD showSuccessHUD:@"输入密码至少6位"];
        return;
        
    }else {
        
        [[HYAPIManager shareInstance]queryUserRegisterWithUserId:name password:password  completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
            
            
            if (!success) {
                [HYHUD showSuccessHUD:error];
            }
            else {
                
                [HYCommonService swicthTabRootController];
                [HYHUD showSuccessHUD:@"注册成功"];
            }
        }];
        
    }
}
+ (void)useLogoutHandle {
    
    [[HYAPIManager shareInstance]queryUserLoginoutWithUserId:        [HYUserManager shareInstance].currentUser.userId completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        if (success) {
            
            [HYCommonService switchLoginController];
            
        }
        
        [HYHUD showSuccessHUD:success?@"退出登录成功":error];
        
    }];
}
@end
