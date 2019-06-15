//
//  HYOrderClassroomHeaderView.m
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYOrderClassroomHeaderView.h"
@interface HYOrderClassroomHeaderView()

@property (nonatomic,strong) UIView *grayBg;
@property (nonatomic,strong) UIImageView *img;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *openTimeLabel;
@property (nonatomic,strong) UILabel *seatLabel;
@property (nonatomic,strong) UILabel *deviceLabel;

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *arrowBtn;
@property (nonatomic,strong) UIButton *backBtn;
@end
@implementation HYOrderClassroomHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    self.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
    [self addSubview:self.grayBg];
    [self addSubview:self.img];
    [self addSubview:self.titleLabel];
    [self addSubview: self.openTimeLabel];
    [self addSubview:self.seatLabel];
    [self addSubview:self.deviceLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.arrowBtn];
    [self addSubview:self.backBtn];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kAdaptedWidth(15));
        make.top.equalTo(self).offset(kAdaptedHeight(18));
        make.width.height.mas_equalTo(kAdaptedHeight(100));
        
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self).offset(kAdaptedHeight(25));
         make.left.equalTo(self.img.mas_right).offset(kAdaptedWidth(15));
    }];
    
    [self.openTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kAdaptedHeight(5));
        make.left.equalTo(self.titleLabel.mas_left);
    }];
    
    [self.seatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.openTimeLabel.mas_bottom).offset(kAdaptedHeight(10));
        make.left.equalTo(self.titleLabel.mas_left);
    }];
    [self.deviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.img.mas_bottom);
        make.left.equalTo(self.titleLabel.mas_left);
    }];
    
    [self.grayBg mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(self.img.mas_bottom).offset(kAdaptedHeight(25));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(kAdaptedHeight(13));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.grayBg.mas_bottom).offset(kAdaptedHeight(20));
        make.centerX.equalTo(self);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.mas_left).offset(kAdaptedWidth(40));
        make.centerY.equalTo(self.timeLabel);
        make.height.mas_equalTo(kAdaptedHeight(20));
        make.width.mas_equalTo(kAdaptedWidth(40));
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.equalTo(self.backBtn);
        make.right.equalTo(self.mas_right).offset(kAdaptedWidth(-40));
    }];
}


- (UIImageView *)img {
    if (!_img) {
        _img = [[UIImageView alloc]init];
    }
    return _img;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _titleLabel.font = kSystemFontSize(18);
    }
    return _titleLabel;
}
- (UILabel *)openTimeLabel {
    if (!_openTimeLabel) {
        _openTimeLabel = [[UILabel alloc]init];
        _openTimeLabel.textColor = COLOR_JJ_TEXT_Describe;
        _openTimeLabel.font = kSystemFontSize(14);
    }
    return _openTimeLabel;
}
- (UILabel *)seatLabel {
    if (!_seatLabel) {
        _seatLabel = [[UILabel alloc]init];
        _seatLabel.textColor = COLOR_JJ_TEXT_Describe;
        _seatLabel.font = kSystemFontSize(14);
    }
    return _seatLabel;
}

- (UILabel *)deviceLabel {
    if (!_deviceLabel) {
        _deviceLabel = [[UILabel alloc]init];
        _deviceLabel.textColor = COLOR_JJ_TEXT_Describe;
        _deviceLabel.font = kSystemFontSize(14);
    }
    return _deviceLabel;
}
- (UIView *)grayBg
{
    if (!_grayBg) {
        _grayBg = [[UIView alloc]init];
        _grayBg.backgroundColor  = COLOR_JJ_BACKGROUND;
    }
    return _grayBg;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _timeLabel.font = kSystemFontSize(16);
        _timeLabel.text = [[NSDate date] stringWithFormat:@"yyyy年MM月dd日"];
       
    }
    return _timeLabel;
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"icon_back_black"] forState:0];
        [_backBtn addTarget:self action:@selector(tapBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowBtn setImage:[UIImage imageNamed:@"icon_arrow_black"] forState:0];
        [_arrowBtn addTarget:self action:@selector(tapArrowBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}
- (void)tapArrowBtn {
    if (self.handle) {
        self.handle();
    }
}
- (void)tapBack {
    if (self.handle) {
        self.handle();
    }
}
- (void)setClassroomModel:(HYClassroomModel *)classroomModel {
    _classroomModel = classroomModel;
    self.img.image = [UIImage imageNamed:_classroomModel.img];
    self.titleLabel.text = _classroomModel.name;
    self.openTimeLabel.text = [NSString stringWithFormat:@"开放时间: %@",_classroomModel.openTime];
    self.seatLabel.text = [NSString stringWithFormat:@"座位: %@",_classroomModel.seat];
    self.deviceLabel.text = [NSString stringWithFormat:@"设备: %@",_classroomModel.device];
}
- (void)setDate:(NSString *)date {
    _date = date;
    self.timeLabel.text = _date;
}
@end
