//
//  HYClassromFloorCollectionHeaderView.m
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYClassromFloorCollectionHeaderView.h"
@interface HYClassromFloorCollectionHeaderView()


@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *iconLabel;

@end
@implementation HYClassromFloorCollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.iconLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(20);
            make.centerY.equalTo(self);
        }];
        
        [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.left.equalTo(self.mas_left).offset(10);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(3);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kSystemFontSize(14);
        _titleLabel.textColor = COLOR_JJ_TEXT_MAIN;

    }
    return _titleLabel;
}

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc]init];
        _iconLabel.backgroundColor = COLOR_JJ_BLUE_THEME;
       
    }
    return _iconLabel;
}
@end
