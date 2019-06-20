//
//  HYClassroomFloorCollectionCell.m
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYClassroomFloorCollectionCell.h"
@interface HYClassroomFloorCollectionCell()

@property (nonatomic,strong) UILabel *titleLabel;


@end
@implementation HYClassroomFloorCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(1);
                       make.left.equalTo(self.contentView.mas_left).offset(1);
                       make.right.equalTo(self.contentView.mas_right).offset(-1);
                    make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        }];
    }
    return self;
}
- (void)setFloor:(NSString *)floor {
    _floor = floor;
    _titleLabel.text = _floor;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kSystemFontSize(14);
        _titleLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _titleLabel.layer.borderColor = COLOR_JJ_TEXT_Describe.CGColor;
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.layer.cornerRadius = 8;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (void)setIsSelectedRoom:(BOOL)isSelectedRoom {
    _isSelectedRoom = isSelectedRoom;
    _titleLabel.layer.borderColor =_isSelectedRoom? COLOR_JJ_THEME.CGColor: COLOR_JJ_TEXT_Describe.CGColor;
}

@end

