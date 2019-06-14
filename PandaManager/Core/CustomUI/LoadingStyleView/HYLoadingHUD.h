//
//  HYLoadingHUD.h
//  YQD
//
//  Created by lish on 2018/10/19.
//  Copyright © 2018年 lish. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYLoadingHUD : UIView

DEF_SINGLETON(HYLoadingHUD);

+ (void)showLoadingHUD;

+ (void)showLoadingHUD:(NSString *)messgae;

+ (void)showLoadingHUD:(NSString *)messgae onView:(UIView *)view;

+ (void)hiddenLoadingHUD;
@end

NS_ASSUME_NONNULL_END
