//
//  HYSubmitButton.h
//  YQD
//
//  Created by lish on 2018/11/2.
//  Copyright © 2018年 lish. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^HYSubmitButtonClickHandle)(void);
@interface HYSubmitButton : UIButton

@property (nonatomic,strong) UIColor *backgroundColor;

@property (nonatomic,strong) UIColor *highlightedColor;

@property (nonatomic,strong) UIColor *disabledColor;

@property (nonatomic,assign) CGFloat cornerRadius;

@property (nonatomic,assign) CGFloat borderWidth;

@property (nonatomic,strong) UIColor *borderColor;

@property (nonatomic,strong) UIColor *titleColor;

@property (nonatomic,assign) CGFloat titleFont;

@property (nonatomic,copy) NSString *titleString;

@property (nonatomic,copy) HYSubmitButtonClickHandle clickHandle;


@end

NS_ASSUME_NONNULL_END
