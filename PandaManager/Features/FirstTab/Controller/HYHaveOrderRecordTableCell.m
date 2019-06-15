//
//  HYHaveOrderRecordTableCell.m
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYHaveOrderRecordTableCell.h"
@interface HYOrderRecordView ()

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation HYOrderRecordView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.icon];
        [self addSubview:self.timeLabel];
        [self addSubview:self.nameLabel];
        
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.centerY.equalTo(self);
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(20);
            make.centerY.equalTo(self);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_right).offset(50);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = COLOR_JJ_TEXT_Describe;
        
        _timeLabel.font = kSystemFontSize(16);
        
    }
    return _timeLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = COLOR_JJ_TEXT_Describe;
        
        _nameLabel.font = kSystemFontSize(16);
        
    }
    return _nameLabel;
}
- (void)setOrderModel:(HYOrderModel *)orderModel {
    _orderModel = orderModel;
    _timeLabel.text = _orderModel.orderTime;
   
    BOOL other = [[HYUserManager shareInstance].currentUser.userId isEqualToString:_orderModel.orderUserId]?YES:NO;
    _nameLabel.text =other? @"您的预约":@"他人已预约";
    _icon.image = [UIImage imageNamed:other?@"icon_green_point":@"icon_red_point"];
    
    _timeLabel.textColor = other?COLOR_JJ_TEXT_MAIN:COLOR_JJ_TEXT_Describe;
     _nameLabel.textColor = other?COLOR_JJ_TEXT_MAIN:COLOR_JJ_TEXT_Describe;
    
}
@end
@interface HYHaveOrderRecordTableCell()

@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UILabel *bottomLabel;

@property (nonatomic,strong) UIView *middleView;



@end
@implementation HYHaveOrderRecordTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        self.contentView.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.bottomLabel];
        [self.contentView addSubview:self.middleView];
        
        [self.topLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(15);
        }];
        [self.middleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(kAdaptedHeight(125));
            make.top.equalTo(self.topLabel.mas_bottom).offset(10);
        }];
        [self.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.mas_left).offset(15);
             make.top.equalTo(self.middleView.mas_bottom).offset(kAdaptedHeight(27));
        }];
    }
    return self;
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _topLabel.font = kBoldSystemFontSize(16);
        _topLabel.text = @"已被预约";
    }
    return _topLabel;
}
- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.textColor =COLOR_JJ_TEXT_MAIN;
        _bottomLabel.font = kBoldSystemFontSize(16);
        _bottomLabel.text = @"您还可以继续预约当日其它时间段：";
    }
    return _bottomLabel;
}

- (UIView *)middleView {
    if (!_middleView) {
        _middleView = [[UIView alloc]init];
        _middleView.backgroundColor = COLOR_JJ_BACKGROUND;
        _middleView.layer.cornerRadius = 5;
        _middleView.layer.masksToBounds = YES;
    }
    return _middleView;
}
- (void)setOrderModels:(NSArray<HYOrderModel *> *)orderModels {
   
    _orderModels = orderModels;
    
    [_middleView removeAllSubviews];
    
    if (_orderModels.count > 4) {
        [self.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kAdaptedHeight(125)+kAdaptedHeight(30)*(self.orderModels.count-4));
        }];
    }else {
          [self.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
          make.height.mas_equalTo(kAdaptedHeight(125));
        }];
    }
    [self layoutIfNeeded];
    
    [_orderModels enumerateObjectsUsingBlock:^(HYOrderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        HYOrderRecordView *view = [[HYOrderRecordView alloc]initWithFrame:CGRectMake(0, 10+kAdaptedHeight(20)*idx+10*idx, kScreenWidth-30, kAdaptedHeight(20))];
        view.orderModel = obj;
        [self.middleView addSubview:view];
        
    }];
    
}
@end
