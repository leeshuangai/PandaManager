//
//  HYArrowTextCustomView.m
//  MeiFuTang
//
//  Created by lish on 2019/6/13.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYArrowTextCustomView.h"

@interface HYArrowTextCustomView()

@property (nonatomic,strong) UIView *bg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *iconImg;
@property (nonatomic,strong) UIView *line;

@end
@implementation HYArrowTextCustomView
- (instancetype)initWithName:(NSString *)name placeholder:(NSString *)placeholder icon:(NSString *)icon {
    self = [super init];
    if (self) {
        
        [self initUI];
        self.name = name;
        self.placeholder = placeholder;
        self.icon = icon;
    }
    return self;
}
- (instancetype)init {
    
    
    self = [super init];
    if (self) {
        
        [self initUI];
        
    }
    return self;
    
}
- (void)initUI {
    
    [self addSubview:self.bg];
    [self addSubview:self.nameLabel];
    [self addSubview:self.tf];
    [self addSubview:self.iconImg];
    [self addSubview:self.line];
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.bottom.equalTo(self);
        
    }];
    
  
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.bg);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(15);
        make.centerY.equalTo(self.bg);
    }];
   
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-30);
        make.centerY.equalTo(self.bg);
        
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
    }];
}
- (void)setName:(NSString *)name {
    _name = name;
    _nameLabel.text = _name;
   
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.tf.placeholder = _placeholder;
}
- (void)setIcon:(NSString *)icon {
    _icon = icon;
    self.iconImg.image = [UIImage imageNamed:_icon];
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _nameLabel.font = kSystemFontSize(14);
    }
    return _nameLabel;
}
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
    }
    return _iconImg;
}
- (UITextField *)tf {
    if (!_tf) {
        _tf = [[UITextField alloc]init];
        _tf.font = kSystemFontSize(12);
        _tf.textAlignment = NSTextAlignmentRight;
    }
    
    return _tf;
}
- (UIView *)bg {
    if (!_bg) {
        _bg = [[UIView alloc]init];
        _bg.backgroundColor = [UIColor whiteColor];
       
    }
    
    return _bg;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = COLOR_JJ_Alert_LINE;
    }
    return _line;
}

@end
