//
//  HYCustomSearchBar.m
//  YQD
//
//  Created by lish on 2019/3/13.
//  Copyright © 2019 lish. All rights reserved.
//

#import "HYCustomSearchBar.h"
@interface HYCustomSearchBar()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *bg;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UITextField *textField;

@end
@implementation HYCustomSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        
        [self addSubview:self.bg];
        [self.bg addSubview:self.icon];
        [self.bg addSubview:self.textField];
        [self setFrame];
    }
    return self;
}
- (instancetype)initWithPlaceholder:(NSString *)placeholder {
    
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        
        [self addSubview:self.bg];
        [self.bg addSubview:self.icon];
        [self.bg addSubview:self.textField];
        [self setFrame];
        self.textField.placeholder = placeholder;
        
    }
    return self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(hy_customSearchBar:shouldReturnTextField:)]) {
        [self.delegate hy_customSearchBar:self shouldReturnTextField:textField];
    }
    return YES;
}

- (void )textFieldResignFirstResponder {
    [self.textField resignFirstResponder];
}

- (void)tf_changed:(UITextField *)textField {
    

    if (textField.text.isNotBlank) {
        
        if ([self.delegate respondsToSelector:@selector(hy_customSearchBar:willTextFieldChanged:)]) {
            [self.delegate hy_customSearchBar:self willTextFieldChanged:textField];
        }
        
    }else {
        if ([self.delegate respondsToSelector:@selector(hy_customSearchBar:shouldClearTextField:)]) {
            [self.delegate hy_customSearchBar:self shouldClearTextField:textField];
        }
        
    }
    
}
- (void)becomeFirstResponder {
      [_textField becomeFirstResponder];
}
- (void)setFrame {
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.top.equalTo(self);
    
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bg);
        make.left.equalTo(self.bg.mas_left).offset(kAdaptedWidth(12));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.bg);
        make.left.equalTo(self.bg.mas_left).offset(40);
        make.right.equalTo(self.bg.mas_right).offset(-10);
    }];
    
    
    
}
- (UIView *)bg {
    if (!_bg) {
        _bg = [[UIView alloc]init];
        _bg.backgroundColor = COLOR_JJ_GRAY_BACK;
        _bg.layer.cornerRadius = 14;
        _bg.layer.masksToBounds = YES;
    }
    return _bg;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"1616_SekGreyaaalin"];
    }
    return _icon;
}



- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"搜索";
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = kSystemFontSize(14);
        _textField.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
        [_textField addTarget:self action:@selector(tf_changed:) forControlEvents:UIControlEventEditingChanged];
      
    }
    return _textField;
}
@end
