//
//  UIImage+Gradient.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Gradient)

+(UIImage *)createGradientImageWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end
