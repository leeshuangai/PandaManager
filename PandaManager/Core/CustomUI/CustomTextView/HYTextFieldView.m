//
//  HYTextFieldView.m
//  YQD
//
//  Created by lish on 2018/10/23.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "HYTextFieldView.h"

@interface HYTextFieldView()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UILabel *titleLabel;

@end
@implementation HYTextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
    
}
- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    
    self = [super init];
    if (self) {
       
        [self initUI];
        self.title = title;
        self.placeholder = placeholder;
       
    }
    return self;
    
}

- (void)initUI {
    self.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
    
    [self addSubview:self.titleLabel];
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
    

   
   
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kAdaptedWidth(20));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(kAdaptedWidth(100));
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
       
         make.right.equalTo(self.mas_right).offset(kAdaptedWidth(-20));
         make.left.equalTo(self.titleLabel.mas_right);
         make.top.equalTo(self);
         make.bottom.equalTo(self.mas_bottom).offset(-1);
        
    }];
    
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
 
}
- (void)setTitle:(NSString *)title {
    
    _title = title;
    _titleLabel.text = _title;
    CGFloat width = [_title widthForFont:kSystemFontSize(14)];
    
    if (width <  kAdaptedWidth(100)) {
        width =  kAdaptedWidth(100);
    }
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ceil(width));
    }];

    [self layoutIfNeeded];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _textField.placeholder = _placeholder;
    
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _titleLabel.font = kSystemFontSize(14);
        _titleLabel.text = @"姓名";
        
    }
    return _titleLabel;
    
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

@end
