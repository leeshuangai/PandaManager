//
//  HYAvaterCustomCell.m
//  MeiFuTang
//
//  Created by lish on 2019/6/13.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYAvaterCustomCell.h"
@interface HYAvaterCustomCell()


@property (nonatomic,strong) UIImageView *avaterImg;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *arrowImg;


@end
@implementation HYAvaterCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}


- (void)initUI {
    [self addSubview:self.avaterImg];
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowImg];
    [self.avaterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-30);
        make.width.height.mas_equalTo(kAdaptedHeight(46));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-15);
        
    }];
    self.userInteractionEnabled = YES;
    @weakify(self);
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        if (self.selectedHandle) {
            self.selectedHandle();
        }
    }];
    [self addGestureRecognizer:tap];
}
- (void)setAvaterData:(NSData *)avaterData {
    _avaterData = avaterData;
    
    _avaterImg.image = [UIImage imageWithData:avaterData];
    _arrowImg.image = [UIImage imageNamed:@"icon_arrow"];
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _titleLabel.font = kSystemFontSize(16);
        _titleLabel.text = @"头像";
    }
    return _titleLabel;
}

- (UIImageView *)avaterImg {
    if (!_avaterImg) {
        _avaterImg = [[UIImageView alloc]init];
        _avaterImg.layer.cornerRadius = kAdaptedHeight(46)/2;
        _avaterImg.layer.masksToBounds = YES;
        _avaterImg.backgroundColor = COLOR_JJ_BACKGROUND;
        _avaterImg.image = [UIImage imageNamed:@"icon_default"];
    }
    return _avaterImg;
}
- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc]init];
        
    }
    return _arrowImg;
}
@end
