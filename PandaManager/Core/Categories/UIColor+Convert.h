//
//  UIColor+Category.h
//  YQD
//
//  Created by lish on 2018/9/27.
//  Copyright © 2018年 lish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Convert)


+ (UIColor*)colorRGBConvertToHSB:(UIColor*)color withAlphaDelta:(CGFloat)delta;
- (UIColor *)convertToHSBwithBrighnessDelta:(CGFloat)delta;
- (UIColor *)convertToHSBwithAlphaDelta:(CGFloat)delta;
- (UIColor *)convertToHSBwithAlpha:(CGFloat)alphaVal;
@end
