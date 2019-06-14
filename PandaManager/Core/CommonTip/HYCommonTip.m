//
//  HYCommonTip.m
//  TeamDevelop
//
//  Created by lish on 2019/6/5.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYCommonTip.h"

@implementation HYCommonTip

+ (NSString *)hy_userRegisterWithUserCode:(NSString *)userCode password:(NSString *)password comfirmPassword:(NSString *)comfirmPassword{
    

    if (![userCode checkPhoneNumber]) {
        return @"请输入正确手机号";
    }
    else if (![password isEqualToString:comfirmPassword]){

        return @"两次密码输入不相同";
    }
    
    else if (password.length < 6){
      
        return @"输入密码至少6位";
        
    }
   else {
      return @"";
    }
}

+ (NSString *)hy_userLoginWithUserCode:(NSString *)userCode password:(NSString *)password {
    
    
    if (userCode.isNotBlank && password.isNotBlank) {
        return @"";
    }else {
        return @"请正确输入正确手机号或密码";
    }
}

@end
