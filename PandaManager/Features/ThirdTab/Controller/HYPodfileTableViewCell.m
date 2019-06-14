//
//  HYPodfileTableViewCell.m
//  Panda
//
//  Created by lish on 2019/5/30.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYPodfileTableViewCell.h"
@interface HYPodfileTableViewCell()

@property (nonatomic,strong) UIView *bg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *arrowImg;
@property (nonatomic,strong) UILabel *detailLabel;

@end
@implementation HYPodfileTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    
    }
    return self;
    
}
- (void)initUI {
    [self.contentView addSubview:self.bg];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.arrowImg];
        [self.contentView addSubview:self.detailLabel];
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(kAdaptedHeight(44));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.contentView.mas_left).offset(30);
        make.centerY.equalTo(self.bg);
    }];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.contentView.mas_right).offset(-30);
          make.centerY.equalTo(self.bg);
        
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.centerY.equalTo(self.bg);
        
    }];
}
- (void)setName:(NSString *)name {
    _name = name;
    _nameLabel.text = _name;
    
}
- (void)setDetail:(NSString *)detail {
    _detail = detail;
    _detailLabel.hidden = !_detail.isNotBlank;
    _arrowImg.hidden = _detail.isNotBlank;
    _detailLabel.text = _detail;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _nameLabel.font = kSystemFontSize(16);
    }
    return _nameLabel;
}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _detailLabel.font = kSystemFontSize(16);
        _detailLabel.hidden = YES;
    }
    return _detailLabel;
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
        _bg.layer.cornerRadius = 5;
        _bg.layer.shadowOffset = CGSizeMake(0, 0); //(0,0)时是四周都有阴影
        _bg.layer.shadowRadius = 3.5;
        _bg.layer.shadowColor = COLOR_JJ_TEXT_MAIN.CGColor;
        _bg.layer.shadowOpacity = 0.1;
    }
    
    return _bg;
}
@end
