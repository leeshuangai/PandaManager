//
//  UIView+Gradient.m
//  bbb
//
//  Created by lish on 2017/8/8.
//  Copyright © 2017年 lish. All rights reserved.
//

#import "UIView+Gradient.h"

static NSString * const gradientKey = @"gradientKey";
@implementation UIView (Gradient)

- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    
    [self addGradientWithStartColor:startColor endColor:endColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
}
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius {
    [self addGradientWithStartColor:startColor endColor:endColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) cornerRadius:cornerRadius];
    
}
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    [self addGradientWithStartColor:startColor endColor:endColor startPoint:startPoint endPoint:endPoint cornerRadius:0];
}
- (void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint cornerRadius:(CGFloat)cornerRadius {
    for (CALayer *layer in self.layer.sublayers.copy) {
        if ([layer.name isEqualToString:gradientKey]) {
            [self removeGradientLayer];
        }
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor,nil];
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    gradient.name = gradientKey;
    gradient.cornerRadius = cornerRadius;
    [self.layer insertSublayer:gradient atIndex:0];
}

- (void)removeGradientLayer {
    for (CALayer *layer in self.layer.sublayers.copy) {
        if ([layer.name isEqualToString:gradientKey]) {
            [layer removeFromSuperlayer];
        }
    }
}
@end
