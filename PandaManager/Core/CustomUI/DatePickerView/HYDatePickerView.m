//
//  HYDatePickerView.m
//  YQD
//
//  Created by lish on 2018/12/5.
//  Copyright © 2018 lish. All rights reserved.
//

#import "HYDatePickerView.h"
@interface HYDatePickerView()

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIView *line;


@property (nonatomic,copy) NSString *titleString;

@end
@implementation HYDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    frame = [UIScreen mainScreen].bounds;
    
    self = [super initWithFrame:frame];
    if(self) {
        
        [self initUI];
        
    }
    return self;
}

+ (instancetype)timeDatePickerViewWithTitle:(NSString *)title  {
    
    HYDatePickerView *datePickerView = [[HYDatePickerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    datePickerView.titleString = title;

    [datePickerView.datePickerView setDatePickerMode:UIDatePickerModeTime];
    return datePickerView;
    
}

+ (instancetype)datePickerViewWithTitle:(NSString *)title maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate {
    
    HYDatePickerView *datePickerView = [[HYDatePickerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    datePickerView.titleString = title;
    if (maxDate) {
        [datePickerView.datePickerView setMaximumDate:maxDate];
    }
    if (minDate) {
         [datePickerView.datePickerView setMinimumDate:minDate];
    }
    
    return datePickerView;
    
}

+ (instancetype)datePickerViewWithTitle:(NSString *)title maxDate:(NSDate *)maxDate {
    
    return  [HYDatePickerView datePickerViewWithTitle:title maxDate:maxDate minDate:nil];
    
}
+ (instancetype)datePickerViewWithTitle:(NSString *)title {
 
    return [HYDatePickerView datePickerViewWithTitle:title maxDate:nil minDate:nil];
}

+ (instancetype)datePickerViewWithTitle:(NSString *)title minDate:(NSDate *)minDate {
    
    
    return  [HYDatePickerView datePickerViewWithTitle:title maxDate:nil minDate:minDate];
}



- (void)initUI {
    
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.cancleBtn];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.commitBtn];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.datePickerView];
    [self setFrame];
    
}
#pragma mark event
- (void)show {
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = UIColorHex(00000000);
    self.contentView.transform = CGAffineTransformMakeTranslation(0, kAdaptedHeight(300));
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.backgroundColor = UIColorHex(0000004c);
    }completion:^(BOOL finished) {
    }];
    
    if (_selectedDate) {
        [self.datePickerView setDate:_selectedDate];
    }
}
- (void)setSelectedDate:(NSDate *)selectedDate {
    
    _selectedDate = selectedDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    self.selectedDateFormart = [dateFormatter stringFromDate:_selectedDate];
    
    [self.datePickerView setDate:_selectedDate];
}


- (void)dissmisView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, kAdaptedHeight(300));
        self.backgroundColor = UIColorHex(00000000);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)tapCommit {
    
    [self dissmisView];
    
    _selectedDate = [self.datePickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *currentDateStr = [dateFormatter stringFromDate:_selectedDate];
    
    if (self.selectedDateCompletion) {
        self.selectedDateCompletion(currentDateStr,_selectedDate);
    }
    
}
- (void)tapCancle {
    [self dissmisView];
}
- (void)setFrame {
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(kAdaptedHeight(300));
    }];
    
    [_cancleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.height.mas_equalTo(30);
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.cancleBtn);
    }];
    
    [_commitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(40);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.left.equalTo(self);
        make.top.equalTo(self.contentView.mas_top).offset(50);
        make.height.mas_equalTo(1);
    }];
    
    [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(kAdaptedHeight(16));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(kAdaptedHeight(173));
    }];
    
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
    }
    return _contentView;
    
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = COLOR_JJ_Table_LINE;
    }
    return _line;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setImage:[UIImage imageNamed:@"1616_CrosGreyaaa"] forState:0];
        [_cancleBtn addTarget:self action:@selector(tapCancle) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cancleBtn;
}
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.text = _titleString;
        _titleLable.font = kBoldSystemFontSize(18);
        _titleLable.textColor = COLOR_JJ_TEXT_MAIN;
    }
    return _titleLable;
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_commitBtn setTitle:@" 确定" forState:0];
        _commitBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_commitBtn setTitleColor:COLOR_JJ_ORANGE_THEME forState:0];
        _commitBtn .titleLabel.font = kSystemFontSize(16);
        [_commitBtn addTarget:self action:@selector(tapCommit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}

- (UIDatePicker *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[UIDatePicker alloc]init];
        [_datePickerView setDatePickerMode:UIDatePickerModeDate];
       // [_datePickerView setDatePickerMode:UIDatePickerModeTime];
        
        _datePickerView.locale = [[NSLocale alloc]
                                  initWithLocaleIdentifier:@"zh_CN"];

    }
    return _datePickerView;
}
- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    _titleLable.text = _titleString;
}
@end
