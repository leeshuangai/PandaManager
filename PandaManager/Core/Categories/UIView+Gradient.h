//
//  UIView+Gradient.h
//  bbb
//
//  Created by lish on 2017/8/8.
//  Copyright © 2017年 lish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gradient)


/**
 给UIView及子类添加渐变色 从左至右

 @param startColor 开始的颜色
 @param endColor 结束的颜色
 */
- (void)addGradientWithStartColor:(UIColor *)startColor
                         endColor:(UIColor *)endColor;

/**
 给UIView及子类添加渐变色 从左至右
 
 @param startColor 开始的颜色
 @param endColor 结束的颜色
 @param cornerRadius 圆角大小
 */
- (void)addGradientWithStartColor:(UIColor *)startColor
                         endColor:(UIColor *)endColor
                     cornerRadius:(CGFloat)cornerRadius;

/**
 给UIView及子类添加渐变色 从左至右
 
 @param startColor 开始的颜色
 @param endColor 结束的颜色
 @param startPoint 开始的位置
 @param endPoint 结束的位置
 */
- (void)addGradientWithStartColor:(UIColor *)startColor
                         endColor:(UIColor *)endColor
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint;

/**
 给UIView及子类添加渐变色 从左至右
 
 @param startColor 开始的颜色
 @param endColor 结束的颜色
 @param startPoint 开始的位置
 @param endPoint 结束的位置
 @param cornerRadius 圆角大小
 */
- (void)addGradientWithStartColor:(UIColor *)startColor
                         endColor:(UIColor *)endColor
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint
                     cornerRadius:(CGFloat)cornerRadius;

/**
    移除渐进色的layer
 */
- (void)removeGradientLayer;
@end
