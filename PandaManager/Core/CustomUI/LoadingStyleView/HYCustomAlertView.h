//
//  HYCustomAlertView.h
//  YQD
//
//  Created by lish on 2018/10/29.
//  Copyright © 2018年 lish. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYCustomAlertView;
typedef void (^HYCustomAlertViewHandle)(HYCustomAlertView *alert);
NS_ASSUME_NONNULL_BEGIN

@interface HYCustomAlertView : UIView

@property (nonatomic,copy) HYCustomAlertViewHandle cancleHandle;
@property (nonatomic,copy) HYCustomAlertViewHandle commitHandle;

+ (instancetype)alertViewWithDetail:(id)detail;

+ (instancetype)alertViewWithDetail:(id)detail cancleTitle:(NSString *)cancleTitle commitTitle:(NSString *)commitTitle cancleHandle:(HYCustomAlertViewHandle)cancleHandle commitHandle:(HYCustomAlertViewHandle)commitHandle;

+ (instancetype)alertViewWithDetail:(id)detail cancleTitle:(NSString *)cancleTitle cancleHandle:(HYCustomAlertViewHandle)cancleHandle;


+ (instancetype)alertViewWithDetail:(id)detail  commitTitle:(NSString *)commitTitle commitHandle:(HYCustomAlertViewHandle)commitHandle;

- (void)showView;

- (void)dismissView;

@end

NS_ASSUME_NONNULL_END
