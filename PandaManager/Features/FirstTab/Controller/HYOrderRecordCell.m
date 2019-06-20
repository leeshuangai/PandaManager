//
//  HYOrderRecordCell.m
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYOrderRecordCell.h"
@interface HYOrderRecordCell()

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIImageView *statusIcon;

@property (nonatomic,strong) UILabel *classNameLabel;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIButton *cancleOrderBtn;

@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UILabel *monthLabel;

@property (nonatomic,strong) UILabel *dayLabel;

@property (nonatomic,strong) UILabel *adderssLabel;

@property (nonatomic,strong) UIImageView *avaterImg;

@property (nonatomic,strong) UILabel *nameLabel;

@end
@implementation HYOrderRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        self.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
     [self.contentView addSubview:self.bgView];
     [self.contentView addSubview:self.classNameLabel];
     [self.contentView addSubview:self.adderssLabel];
    
     [self.contentView addSubview:self.avaterImg];
     [self.contentView addSubview:self.nameLabel];

      [self.contentView addSubview:self.timeLabel];
    
     [self.contentView addSubview:self.line];
     [self.contentView addSubview:self.statusIcon];
     [self.contentView addSubview:self.cancleOrderBtn];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(kAdaptedHeight(15));;
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kAdaptedHeight(15));;
    }];
    
    
    [self.avaterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(kAdaptedWidth(15));
        make.top.equalTo(self.bgView.mas_top).offset(kAdaptedHeight(15));
        make.width.height.mas_equalTo(kAdaptedWidth(40));
    }];
    
    self.avaterImg.backgroundColor = [UIColor redColor];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.avaterImg.mas_bottom).offset(10);
        make.width.mas_equalTo(self.avaterImg);
        make.centerX.equalTo(self.avaterImg);
    }];

    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avaterImg.mas_right).offset(kAdaptedWidth(20));
        make.centerY.equalTo(self.bgView);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(kAdaptedHeight(100));
    }];
    [self.classNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.bgView.mas_top).offset(kAdaptedHeight(15));
       make.left.equalTo(self.line.mas_right).offset(kAdaptedWidth(20));
        make.width.mas_equalTo(kAdaptedWidth(140));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.classNameLabel.mas_bottom).offset(kAdaptedHeight(15));
        make.left.right.equalTo(self.classNameLabel);
    }];
    [self.adderssLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(kAdaptedHeight(15));
        make.left.right.equalTo(self.classNameLabel);
    }];
    
    [self.statusIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.classNameLabel.mas_top);
        make.right.equalTo(self.bgView.mas_right);
        make.width.mas_equalTo(kAdaptedWidth(88));
        make.height.mas_equalTo(kAdaptedWidth(25));
    }];
    
    [self.cancleOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView.mas_bottom).offset(kAdaptedHeight(-22));
        make.right.equalTo(self.bgView.mas_right).offset(-12);
        make.width.mas_equalTo(kAdaptedWidth(90));
        make.height.mas_equalTo(kAdaptedWidth(25));
    }];
}
- (void)setOrderModel:(HYOrderModel *)orderModel {
    _orderModel = orderModel;
    
    _classNameLabel.text = _orderModel.className;
    _timeLabel.text =_orderModel.orderTime;
    if ([_orderModel.orderStatus isEqualToString:@"预约成功"]) {
        
        _statusIcon.image = [UIImage imageNamed:@"icon_order_success"];
                _cancleOrderBtn.hidden =NO;
    }else{
        
         _statusIcon.image = [UIImage imageNamed:@"icon_order_cancle"];
        _cancleOrderBtn.hidden =YES;
    }
    
    self.adderssLabel.text = [NSString stringWithFormat:@"%@%@",_orderModel.orderClassroom,_orderModel.classFloor];
    

    self.avaterImg.image = [UIImage imageWithData:_orderModel.orderAvaterData];
    self.nameLabel.text = [[[NSString stringWithFormat:@"%@\n%@",_orderModel.orderNameDepartment ,_orderModel.orderUserName] stringByReplacingOccurrencesOfString:@"院系：" withString:@""]stringByReplacingOccurrencesOfString:@"姓名：" withString:@""];
    
}
- (void)tapCancleOrderBtn {
    
    
    if ([self.delegate respondsToSelector:@selector(hy_orderRecordCell:didCancleOrder:)]) {
        [self.delegate hy_orderRecordCell:self didCancleOrder:self.orderModel];
    }
}
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
 
        CALayer *layer = [_bgView layer];
        layer.shadowOffset = CGSizeMake(0, -20); //(0,0)时是四周都有阴影
        layer.shadowOffset = CGSizeMake(0, 0);
        layer.shadowRadius = 10.0;
        layer.shadowColor = COLOR_JJ_TEXT_Describe.CGColor;
        layer.shadowOpacity = 0.5;
        layer.cornerRadius = 10;
    }
    return _bgView;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = COLOR_JJ_LINE;
    }
    return _line;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _nameLabel.font = kSystemFontSize(10);
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}


- (UILabel *)classNameLabel {
    if (!_classNameLabel) {
        _classNameLabel = [[UILabel alloc]init];
        _classNameLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _classNameLabel.font = kSystemFontSize(14);
    }
    return _classNameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = COLOR_JJ_BLUE_THEME;
        _timeLabel.font = kSystemFontSize(14);
    }
    return _timeLabel;
}
- (UILabel *)adderssLabel {
    if (!_adderssLabel) {
        _adderssLabel = [[UILabel alloc]init];
        _adderssLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _adderssLabel.font = kSystemFontSize(16);
    }
    return _adderssLabel;
}

- (UIButton *)cancleOrderBtn {
    if (!_cancleOrderBtn) {
        _cancleOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleOrderBtn setTitleColor:COLOR_JJ_BLUE_THEME forState:0];
        [_cancleOrderBtn setTitle:@"取消他的预约" forState:0];
        [_cancleOrderBtn addTarget:self action:@selector(tapCancleOrderBtn) forControlEvents:UIControlEventTouchUpInside];
        _cancleOrderBtn.layer.cornerRadius = kAdaptedHeight(12);
        _cancleOrderBtn.layer.borderColor = COLOR_JJ_BLUE_THEME.CGColor;
        _cancleOrderBtn.layer.borderWidth = 1;
        _cancleOrderBtn .titleLabel.font = kSystemFontSize(10);
    }
    return _cancleOrderBtn;
}
- (UIImageView *)avaterImg {
    if (!_avaterImg) {
        _avaterImg = [[UIImageView alloc]init];
        _avaterImg.backgroundColor = COLOR_JJ_BACKGROUND;
        
        _avaterImg.layer.cornerRadius = kAdaptedWidth(40)/2;
        _avaterImg.layer.masksToBounds = YES;
        
    }
    return _avaterImg;
}
- (UIImageView *)statusIcon {
    if (!_statusIcon) {
        _statusIcon = [[UIImageView alloc]init];
        _statusIcon.image = [UIImage imageNamed:@"icon_order_success"];
    }
    return _statusIcon;
}
@end
