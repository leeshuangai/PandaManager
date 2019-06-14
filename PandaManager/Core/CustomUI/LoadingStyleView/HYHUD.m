//
//  HYHUD.m
//  YQD
//
//  Created by lish on 2018/10/10.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "HYHUD.h"
#import "HYPromptView.h"
#import "HYLoadingHUD.h"
#define kKeyWindow [UIApplication sharedApplication].keyWindow
@implementation HYHUD

+ (void)showLoadingHUD {
    
    
    [HYLoadingHUD showLoadingHUD];
}

+ (void)showLoadingHUD:(NSString *)messgae {
    
    [HYLoadingHUD showLoadingHUD:messgae];
}




+ (void)showLoadingHUD:(NSString *)messgae onView:(UIView *)view {
    
    
    [HYLoadingHUD showLoadingHUD:messgae onView:view];
}

+ (void)hiddenLoadingHUD {
    
    [HYLoadingHUD hiddenLoadingHUD];
    
}

//显示成功
+ (void)showSuccessHUD:(NSString *)messgae {
    
    [HYPromptView  showSuccessHUD:messgae];
    
    
    
}

+ (void)showSuccessHUD:(NSString *)messgae onView:(UIView *)view {
    
    
    [HYPromptView showSuccessHUD:messgae onView:view];
    
}


//显示error
+ (void)showErrorHUD:(NSString *)messgae {
    
    
    [HYPromptView  showErrorHUD:messgae];
    
}

+ (void)showErrorHUD:(NSString *)messgae onView:(UIView *)view{
    
    
    [HYPromptView showErrorHUD:messgae onView:view];
    
}


@end
