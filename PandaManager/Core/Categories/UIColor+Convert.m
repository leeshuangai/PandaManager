//
//  UIColor+Category.m
//  YQD
//
//  Created by lish on 2018/9/27.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "UIColor+Convert.h"

@implementation UIColor (Convert)
+ (UIColor*)colorRGBConvertToHSB:(UIColor*)color withAlphaDelta:(CGFloat)delta {
    CGFloat hue = 0.0f;
    CGFloat saturation = 0.0f;
    CGFloat brightness = 0.0f;
    CGFloat alpha = 0.0f;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    alpha += delta;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}
+ (UIColor*)colorRGBConvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta {
    CGFloat hue = 0.0f;
    CGFloat saturation = 0.0f;
    CGFloat brightness = 0.0f;
    CGFloat alpha = 0.0f;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    brightness += delta;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}
+ (UIColor*) colorRGBConvertToHSB:(UIColor*)color withAlpha:(CGFloat)alphaVal {
    CGFloat hue = 0.0f;
    CGFloat saturation = 0.0f;
    CGFloat brightness = 0.0f;
    CGFloat alpha = 0.0f;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    alpha = alphaVal;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}
- (UIColor *)convertToHSBwithBrighnessDelta:(CGFloat)delta {
    return [UIColor colorRGBConvertToHSB:self withBrighnessDelta:delta];
}
- (UIColor *)convertToHSBwithAlphaDelta:(CGFloat)delta {
    return [UIColor colorRGBConvertToHSB:self withAlphaDelta:delta];
}

- (UIColor *)convertToHSBwithAlpha:(CGFloat)alphaVal {
    return [UIColor colorRGBConvertToHSB:self withAlpha:alphaVal];
}
@end
