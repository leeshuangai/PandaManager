//
//  HYHUD.h
//  YQD
//
//  Created by lish on 2018/10/10.
//  Copyright © 2018年 lish. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYHUD : NSObject
/**
 @note 在窗口上显示加载动画
 
 */
+ (void)showLoadingHUD;

/**
 @note 在窗口上显示加载动画
 @param messgae 加载文字
 */
+ (void)showLoadingHUD:(NSString *)messgae;



/**
 @note 显示加载动画
 @param messgae 加载文字
 @param view 显示在View上
 */
+ (void)showLoadingHUD:(NSString *)messgae onView:(UIView *)view;

/**
 @note 隐藏加载动画

 */
+ (void)hiddenLoadingHUD;
//
//
/**
 @note 在窗口上显示成功提示
 @param messgae 加载文字

 */
+ (void)showSuccessHUD:(NSString *)messgae;


/**
 @note 在窗口上显示成功文字
 @param messgae 加载文字
 @param view  加载视图
 */
+ (void)showSuccessHUD:(NSString *)messgae onView:(UIView *)view;


/**
 @note 在窗口上显示警告文字
 @param messgae 加载文字
 */
+ (void)showErrorHUD:(NSString *)messgae;


/**
 @note 在窗口上显示警告文字
 @param messgae 加载文字
 @param view  加载视图
 */
+ (void)showErrorHUD:(NSString *)messgae onView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
