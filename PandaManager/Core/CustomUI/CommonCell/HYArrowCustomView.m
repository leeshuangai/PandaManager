//
//  HYArrowCustomView.m
//  MeiFuTang
//
//  Created by lish on 2019/6/13.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYArrowCustomView.h"

@interface HYArrowCustomView()

@property (nonatomic,strong) UIView *bg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *arrowImg;
@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) UIImageView *iconImg;
@end
@implementation HYArrowCustomView
- (instancetype)initWithName:(NSString *)name detail:(NSString *)detail icon:(NSString *)icon {
    self = [super init];
    if (self) {
        
        [self initUI];
        self.name = name;
        self.detail = detail;
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
    [self addSubview:self.iconImg];
    [self addSubview:self.nameLabel];
    [self addSubview:self.arrowImg];
    [self addSubview:self.detailLabel];
    
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
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-30);
       make.centerY.equalTo(self.bg);
//        make.height.mas_equalTo(kAdaptedHeight(20));
//        make.width.mas_equalTo(kAdaptedWidth(30));
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImg.mas_left).offset(-10);
        make.centerY.equalTo(self.bg);
        
    }];
    
    self.userInteractionEnabled = YES;
    @weakify(self);
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        if (self.tapArrowHandle) {
            self.tapArrowHandle();
        }
        if (self.tapArrowNameHandle) {
            self.tapArrowNameHandle(self.name);
        }
    }];
    [self addGestureRecognizer:tap];
}
- (void)setName:(NSString *)name {
    _name = name;
    _nameLabel.text = _name;

}
- (void)setDetail:(NSString *)detail {
    _detail = detail;
//    _detailLabel.hidden = !_detail.isNotBlank;
//    _arrowImg.hidden = _detail.isNotBlank;
    _detailLabel.text = _detail;
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
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _detailLabel.font = kSystemFontSize(12);
       // _detailLabel.hidden = YES;
    }
    return _detailLabel;
}
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
    }
    return _iconImg;
}
- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_arrow"]];
       
    }
    return _arrowImg;
}
- (UIView *)bg {
    if (!_bg) {
        _bg = [[UIView alloc]init];
        _bg.backgroundColor = [UIColor whiteColor];
//        _bg.layer.cornerRadius = 5;
//        _bg.layer.shadowOffset = CGSizeMake(0, 0); //(0,0)时是四周都有阴影
//        _bg.layer.shadowRadius = 3.5;
//        _bg.layer.shadowColor = COLOR_JJ_TEXT_MAIN.CGColor;
//        _bg.layer.shadowOpacity = 0.1;
    }
    
    return _bg;
}

@end
