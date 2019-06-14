//
//  HYSubmitButton.m
//  YQD
//
//  Created by lish on 2018/11/2.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "HYSubmitButton.h"

@implementation HYSubmitButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.masksToBounds = YES;
        self.titleColor = COLOR_JJ_DEFAULT_WHITE;
        self.titleFont = 16;
        self.backgroundColor = COLOR_JJ_THEME;

        self.cornerRadius = 20;
        self.titleString = @"提 交";

        [self addTarget:self action:@selector(tapCommitBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    
    _backgroundColor = backgroundColor;
    [self setBackgroundImage:[UIImage imageWithColor:_backgroundColor] forState:UIControlStateNormal];
}
- (void)setHighlightedColor:(UIColor *)highlightedColor {
    _highlightedColor = highlightedColor;
        [self setBackgroundImage:[UIImage imageWithColor:_highlightedColor] forState:UIControlStateHighlighted];
}
- (void)setDisabledColor:(UIColor *)disabledColor {
    
    _disabledColor = disabledColor;
    [self setBackgroundImage:[UIImage imageWithColor:_disabledColor] forState:UIControlStateDisabled];
    
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = _cornerRadius;
}
- (void)setTitleFont:(CGFloat)titleFont {
    _titleFont = titleFont;
    self.titleLabel.font = kSystemFontSize(_titleFont);
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self setTitleColor:_titleColor forState:0];
}
- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    [self setTitle:_titleString forState:UIControlStateNormal];
     [self setTitle:_titleString forState:UIControlStateHighlighted];
     [self setTitle:_titleString forState:UIControlStateDisabled];
}
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}
- (void)tapCommitBtn {
    
    if (self.clickHandle) {
        self.clickHandle();
    }
    
}

@end
