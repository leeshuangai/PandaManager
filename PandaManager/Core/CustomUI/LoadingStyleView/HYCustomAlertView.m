//
//  HYCustomAlertView.m
//  YQD
//
//  Created by lish on 2018/10/29.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "HYCustomAlertView.h"

@interface HYCustomAlertView()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UIButton *commitBtn;

@property (nonatomic,copy) NSString *detailString;
@property (nonatomic,strong) NSString *cancleBtnTitle;
@property (nonatomic,strong) NSString *commitBtnTitle;

@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *line1;//suxian
@end
@implementation HYCustomAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];

    }
    return self;
}

+ (instancetype)alertViewWithDetail:(id)detail cancleTitle:(NSString *)cancleTitle commitTitle:(NSString *)commitTitle cancleHandle:(HYCustomAlertViewHandle)cancleHandle commitHandle:(HYCustomAlertViewHandle)commitHandle {
    
    
    HYCustomAlertView *alertView = [[HYCustomAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if (!commitTitle.isNotBlank && !cancleTitle.isNotBlank) {
        
        commitTitle = @"确定";
        cancleTitle = @"取消";
    }
    
    [alertView initUI];
    alertView.cancleBtnTitle = cancleTitle;
    alertView.commitBtnTitle = commitTitle;
    alertView.detailString = detail;
    alertView.cancleHandle = cancleHandle;
    alertView.commitHandle = commitHandle;
   
   
    [alertView setFrame];
    [alertView showView];
    
    return alertView;
    
}

+ (instancetype)alertViewWithDetail:(id)detail cancleTitle:(NSString *)cancleTitle cancleHandle:(HYCustomAlertViewHandle)cancleHandle {
    
    if (!cancleTitle.isNotBlank) {
        cancleTitle = @"取消";
    }
    return  [self alertViewWithDetail:detail cancleTitle:cancleTitle commitTitle:@"" cancleHandle:cancleHandle commitHandle:nil];
}


+ (instancetype)alertViewWithDetail:(id)detail  commitTitle:(NSString *)commitTitle commitHandle:(HYCustomAlertViewHandle)commitHandle {
    
    if (!commitTitle.isNotBlank) {
        commitTitle = @"确定";
    }
     return  [self alertViewWithDetail:detail cancleTitle:@"" commitTitle:commitTitle cancleHandle:nil commitHandle:commitHandle];
    
}
+ (instancetype)alertViewWithDetail:(id)detail {
    
   return   [self alertViewWithDetail:detail cancleTitle:@"取消" commitTitle:@"确定" cancleHandle:nil commitHandle:nil];
}
- (void)initUI {
   
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.detailLabel];
    [self.bgView addSubview:self.cancleBtn];
    [self.bgView addSubview:self.commitBtn];
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.line1];
}

- (void)setFrame {
 
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(kAdaptedWidth(309));
        make.height.mas_greaterThanOrEqualTo(kAdaptedHeight(150));
    }];
    
    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.bgView);
        make.width.mas_equalTo(kAdaptedWidth(250));
       make.height.mas_greaterThanOrEqualTo(kAdaptedHeight(40));
        make.top.equalTo(self.bgView.mas_top).offset(kAdaptedHeight(40));
     
    }];
    
    [self.cancleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.equalTo(self.bgView);
        make.width.mas_equalTo((!self.commitBtnTitle.isNotBlank &&self.cancleBtnTitle.isNotBlank)? kAdaptedWidth(309):kAdaptedWidth(309)/2);
        make.height.mas_equalTo(kAdaptedHeight(50));
    }];
    
    [self.commitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self.bgView);
        make.width.mas_equalTo((!self.cancleBtnTitle.isNotBlank &&self.commitBtnTitle.isNotBlank)? kAdaptedWidth(309):kAdaptedWidth(309)/2);
        make.height.mas_equalTo(kAdaptedHeight(50));
        
    }];
    
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-kAdaptedHeight(50));
    }];

    [self.line1 mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(self.bgView);
        make.centerX.equalTo(self.bgView);
        make.height.mas_equalTo(kAdaptedHeight(50));
        make.width.mas_equalTo(1);
    }];
    
    if ( !_cancleBtnTitle.isNotBlank || !_commitBtnTitle.isNotBlank) {
        _line1.hidden = YES;
    }
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.detailLabel.mas_bottom).offset(kAdaptedHeight(70));
        
    }];
    [self layoutIfNeeded];
    
    
    
}

- (void)showView {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = [UIColor clearColor];
    self.bgView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
                         self.bgView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
}

- (void)dismissView {
    
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.bgView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
    
}

- (UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        _bgView.userInteractionEnabled = YES;
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds = YES;
        _bgView.preservesSuperviewLayoutMargins = YES;
    }
    return _bgView;
    
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
    
        _detailLabel.font = kSystemFontSize(16);
        _detailLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
       // _detailLabel.backgroundColor = [UIColor orangeColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.preservesSuperviewLayoutMargins = YES;
    }
    return _detailLabel;
}


- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [_cancleBtn addTarget:self action:@selector(tapCancleBtn) forControlEvents:UIControlEventTouchUpInside];
          _cancleBtn.titleLabel.font = kBoldSystemFontSize(16);
          [_cancleBtn setTitleColor:COLOR_JJ_TEXT_MAIN forState:0];
       // _cancleBtn.backgroundColor = [UIColor cyanColor];
        
    }
    return _cancleBtn;
    
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_commitBtn addTarget:self action:@selector(tapCommitBtn) forControlEvents:UIControlEventTouchUpInside];
        [_commitBtn setTitleColor:HEX(0xF51111) forState:0];
        _commitBtn.titleLabel.font = kBoldSystemFontSize(16);
       
        
    }
    return _commitBtn;
    
}


- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = COLOR_JJ_Alert_LINE;
    }
    return _line;
}


- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = COLOR_JJ_Alert_LINE;
    }
    return _line1;
}

- (void)setCancleBtnTitle:(NSString *)cancleBtnTitle {
    _cancleBtnTitle = cancleBtnTitle;
    [_cancleBtn setTitle:_cancleBtnTitle forState:0];
    
    _cancleBtn.hidden = !self.cancleBtnTitle.isNotBlank;
   
}
- (void)setCommitBtnTitle:(NSString *)commitBtnTitle {
    _commitBtnTitle = commitBtnTitle;
    [_commitBtn setTitle:_commitBtnTitle forState:0];
     _commitBtn.hidden = !self.commitBtnTitle.isNotBlank;
}
- (void)setDetailString:(id)detailString {
    _detailString = detailString;
    if ([detailString isKindOfClass:[NSMutableAttributedString class]] ) {
        _detailLabel.attributedText = detailString;
    }else
    {
        _detailLabel.text = _detailString;
    }
   
}

#pragma mark event
- (void)tapCancleBtn {
   
    if (self.cancleHandle) {
        self.cancleHandle(self);
    }
    [self dismissView];
}

- (void)tapCommitBtn {
    
    if (self.commitHandle) {
        self.commitHandle(self);
    }
}
@end
