//
//  HYNoOrderRecordTableCell.m
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYNoOrderRecordTableCell.h"
@interface HYNoOrderRecordTableCell()

@property (nonatomic,strong) UILabel *titleLabel;
@end
@implementation HYNoOrderRecordTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.contentView.mas_top).offset(10);
        }];
    }
    return self;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"该教室当天无预约，点击“开始时间”和“结束时间”进行预约设置，立即预约教室。";
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _titleLabel.font = kBoldSystemFontSize(16);
    }
    return _titleLabel;
}
@end
