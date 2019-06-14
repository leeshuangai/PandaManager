//
//  HYPromptView.h
//  YQD
//
//  Created by lish on 2018/10/16.
//  Copyright © 2018年 lish. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,HYPromptViewType ) {
    
    PromptViewSuccess,
    PromptViewError
    
};
@interface HYPromptView : UIView

DEF_SINGLETON(HYPromptView);

+ (void)showSuccessHUD:(NSString *)messgae;

+ (void)showSuccessHUD:(NSString *)messgae onView:(UIView *)view;

//显示error
+ (void)showErrorHUD:(NSString *)messgae;

+ (void)showErrorHUD:(NSString *)messgae onView:(UIView *)view;



@end

NS_ASSUME_NONNULL_END
