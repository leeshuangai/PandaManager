//
//  UIButton+ResetContent.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/8/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ResetContent)

//上下居中，图片在上，文字在下
- (void)verticalCenterImageAndTitle:(CGFloat)spacing;
- (void)verticalCenterImageAndTitle; //默认6.0

//左右居中，文字在左，图片在右
- (void)horizontalCenterTitleAndImage:(CGFloat)spacing;
- (void)horizontalCenterTitleAndImage; //默认6.0

//左右居中，图片在左，文字在右
- (void)horizontalCenterImageAndTitle:(CGFloat)spacing;
- (void)horizontalCenterImageAndTitle; //默认6.0

//文字居中，图片在左边
- (void)horizontalCenterTitleAndImageLeft:(CGFloat)spacing;
- (void)horizontalCenterTitleAndImageLeft; //默认6.0

//文字居中，图片在右边
- (void)horizontalCenterTitleAndImageRight:(CGFloat)spacing;
- (void)horizontalCenterTitleAndImageRight; //默认6.0

//文字居左距左边的spacing，图片居右距右边的spacing
- (void)horizontalCenterTitleAndImageWithEdge:(CGFloat)spacing;
@end
