//
//  HYOrderClassroomFooterView.m
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYOrderClassroomFooterView.h"
#import "UIButton+ResetContent.h"
@interface HYOrderClassroomFooterView()

@property (nonatomic,strong) UIButton *startBtn;
@property (nonatomic,strong) UIButton *endBtn;

@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;

@end
@implementation HYOrderClassroomFooterView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        
        [self addSubview:self.startBtn];
        [self addSubview:self.endBtn];
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        
        
        [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(20);
            make.width.mas_equalTo(kAdaptedWidth(80));
            make.height.mas_equalTo(kAdaptedHeight(30));
        }];
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.equalTo(self.startBtn.mas_left);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.startBtn.mas_bottom);
        }];

        [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line1.mas_bottom).offset(kAdaptedHeight(20));
            make.left.width.height.equalTo(self.startBtn);
        }];

        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.equalTo(self.startBtn.mas_left);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.endBtn.mas_bottom);
        }];
        
        
        [self.startBtn horizontalCenterImageAndTitle:15];
        [self.endBtn horizontalCenterImageAndTitle:15];
    }
    return self;
}
- (void)tapStartBtn {
    if (self.tapStartBtnHandle) {
        self.tapStartBtnHandle();
    }
}
- (void)tapEndBtn {
    if (self.tapEndBtnHandle) {
        self.tapEndBtnHandle();
    }
}
- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setTitle:@"开始时间" forState:0];
        [_startBtn setImage:[UIImage imageNamed:@"icon_time"] forState:0];
        [ _startBtn setTitleColor:COLOR_JJ_TEXT_MAIN forState:0];
        _startBtn.titleLabel.font  = kSystemFontSize(14);
        [_startBtn addTarget:self action:@selector(tapStartBtn ) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
- (UIButton *)endBtn {
    if (!_endBtn) {
        _endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_endBtn setTitle:@"结束时间" forState:0];
        [_endBtn setImage:[UIImage imageNamed:@"icon_time"] forState:0];
        [ _endBtn setTitleColor:COLOR_JJ_TEXT_MAIN forState:0];
        _endBtn.titleLabel.font  = kSystemFontSize(14);
        [_endBtn addTarget:self action:@selector(tapEndBtn ) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endBtn;
}
- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = COLOR_JJ_LINE;
    }
    return _line2;
}
- (UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = COLOR_JJ_LINE;
    }
    return _line1;
}
- (void)setStartTime:(NSString *)startTime {
    _startTime = startTime;
      [_startBtn setTitle:_startTime forState:0];
}
- (void)setEndTime:(NSString *)endTime {
    _endTime = endTime;
     [_endBtn setTitle:_endTime forState:0];
    
    
}
@end
