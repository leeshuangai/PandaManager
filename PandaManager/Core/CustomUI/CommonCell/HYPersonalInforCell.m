//
//  HYPersonalInforCell.m
//  Panda
//
//  Created by lish on 2019/6/3.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYPersonalInforCell.h"
@interface HYPersonalInforCell()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIView *bg;

@end
@implementation HYPersonalInforCell
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

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(kAdaptedHeight(50));
        
    }];
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.right.bottom.equalTo(self.contentView);
    }];
   
}
- (void)setName:(NSString *)name {
    _name = name;
    _nameLabel.text = _name;
    
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _nameLabel.font = kSystemFontSize(16);
    }
    return _nameLabel;
}

- (UIView *)bg {
    if (!_bg) {
        _bg = [[UIView alloc]init];
       // _bg.backgroundColor = COLOR_JJ_BACKGROUND;
       
    }
    
    return _bg;
}
@end
