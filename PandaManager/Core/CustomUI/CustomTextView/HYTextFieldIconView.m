//
//  HYTextFieldIconView.m
//  YQD
//
//  Created by lish on 2018/10/23.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "HYTextFieldIconView.h"

@interface HYTextFieldIconView()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *icon;

@property (nonatomic,strong) UIView *line;

@property (nonatomic,copy) NSString *placeholder;

@end
@implementation HYTextFieldIconView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
    
}
- (instancetype)initWithPlaceholder:(NSString *)placeholder icon:(NSString *)icon {
    
    self = [super init];
    if (self) {
       
        [self initUI];
        self.placeholder = placeholder;
        self .icon.image = [UIImage imageNamed:icon];
    }
    return self;
    
}

- (void)initUI {
    self.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
    
    [self addSubview:self.icon];
    [self addSubview:self.textField];
    [self addSubview:self.line];

    [self setFrame];
}
- (void)tf_changed:(UITextField *)textField {
    

    if ([self.delegate respondsToSelector:@selector(hy_textFieldView:textChanged:)]) {
        [self.delegate hy_textFieldView:self textChanged:self.textField];
    }
    
}



- (void)setFrame{
    

    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(kAdaptedWidth(12));
        make.height.mas_equalTo(kAdaptedHeight(17));
    }];
    
    
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(kAdaptedWidth(-20));
        make.left.equalTo(self.icon.mas_right).offset(15);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        
    }];
    
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
 
}


- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _textField.placeholder = _placeholder;
    
}
- (void)setIsSecure:(BOOL)isSecure {
    _isSecure = isSecure;
    _textField.secureTextEntry = _isSecure;
}

- (UITextField *)textField {
    
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.font =  kSystemFontSize(14);
        [_textField addTarget:self action:@selector(tf_changed:) forControlEvents:UIControlEventEditingChanged];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.preservesSuperviewLayoutMargins = YES;
        
    }
    return _textField;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = COLOR_JJ_Table_LINE;
    }
    return _line;
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}
@end
