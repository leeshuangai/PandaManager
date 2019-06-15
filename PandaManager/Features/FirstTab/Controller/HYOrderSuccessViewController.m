//
//  HYOrderSuccessViewController.m
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYOrderSuccessViewController.h"

@interface HYOrderSuccessViewController ()
@property (nonatomic,strong) UIImageView *successIcon;
@property (nonatomic,strong) UILabel *successLabel;
@property (nonatomic,strong) UILabel *orderInfoLabel;
@property (nonatomic,strong) UIButton *lookBtn;
@property (nonatomic,strong) UIButton *backHomeBtn;
@end

@implementation HYOrderSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)tapLookBtn {
    

   UITabBarController *tabViewController = (UITabBarController *) [UIApplication sharedApplication].delegate.window.rootViewController;
    [tabViewController setSelectedIndex:2];
   

}

- (void)tapBackHomeBtn {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)initUI {
    
    [self.view addSubview:self.successIcon];
    [self.view addSubview:self.orderInfoLabel];
    [self.view addSubview:self.successLabel];
    [self.view addSubview:self.lookBtn];
    [self.view addSubview:self.backHomeBtn];
    
    
    [self.successIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT+kAdaptedHeight(73));
        make.width.mas_equalTo(kAdaptedWidth(186));
        make.height.mas_equalTo(kAdaptedHeight(140));
        make.centerX.equalTo(self.view);
    }];
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successIcon.mas_bottom).offset(kAdaptedHeight(39));
        make.centerX.equalTo(self.view);
    }];
    [self.orderInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successLabel.mas_bottom).offset(kAdaptedHeight(30));
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(kAdaptedWidth(58));
        make.right.equalTo(self.view.mas_right).offset(kAdaptedWidth(-58));
    }];
    
    
    [self.backHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAdaptedWidth(125));
        make.height.mas_equalTo(kAdaptedHeight(40));
         make.top.equalTo(self.orderInfoLabel.mas_bottom).offset(kAdaptedHeight(46));
        make.left.equalTo(self.view.mas_left).offset(kAdaptedWidth(46));
    }];
    
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAdaptedWidth(125));
        make.height.mas_equalTo(kAdaptedHeight(40));
        make.top.equalTo(self.orderInfoLabel.mas_bottom).offset(kAdaptedHeight(46));
        make.right.equalTo(self.view.mas_right).offset(kAdaptedWidth(-46));
    }];
}
- (void)setOrderModel:(HYOrderModel *)orderModel {
    _orderModel = orderModel;
    
    self.orderInfoLabel.text = [NSString stringWithFormat:@"您预约的%@%@,预约时间%@%@已经预约成功。",self.orderModel.orderClassroom,self.orderModel.classFloor,self.orderModel.orderDate,self.orderModel.orderTime];
}
- (UIImageView *)successIcon {
    if (!_successIcon) {
        _successIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_subcribe"]];
    }
    return _successIcon;
}

- (UILabel *)successLabel {
    if (!_successLabel) {
        _successLabel = [[UILabel alloc]init];
        _successLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _successLabel.text = @"恭喜您，预约成功！";
        _successLabel.font = kBoldSystemFontSize(25);
    }
    return _successLabel;
}


- (UILabel *)orderInfoLabel {
    if (!_orderInfoLabel) {
        _orderInfoLabel = [[UILabel alloc]init];
        _orderInfoLabel .textColor =COLOR_JJ_TEXT_MAIN ;
        _orderInfoLabel .textColor =COLOR_JJ_TEXT_MAIN ;
        _orderInfoLabel .font = kSystemFontSize(16);
        _orderInfoLabel.numberOfLines = 0;
    }
    return _orderInfoLabel;
}

- (UIButton *)lookBtn {
    if (!_lookBtn) {
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookBtn setTitle:@"查看预约" forState:0];
        [_lookBtn setTitleColor:COLOR_JJ_DEFAULT_WHITE forState:0];
        _lookBtn.backgroundColor = COLOR_JJ_BLUE_THEME;
        _lookBtn.layer.cornerRadius = 18;
        _lookBtn.layer.masksToBounds = YES;
        _lookBtn.layer.borderColor = COLOR_JJ_BLUE_THEME.CGColor;
        _lookBtn.layer.borderWidth=1;
                [_lookBtn addTarget:self action:@selector(tapLookBtn ) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookBtn;
}

- (UIButton *)backHomeBtn {
    if (!_backHomeBtn) {
        _backHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backHomeBtn setTitle:@"回到首页" forState:0];
        [_backHomeBtn setTitleColor:COLOR_JJ_BLUE_THEME forState:0];
        _backHomeBtn.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        _backHomeBtn.layer.cornerRadius = 18;
        _backHomeBtn.layer.masksToBounds = YES;
        _backHomeBtn.layer.borderColor = COLOR_JJ_BLUE_THEME.CGColor;
        _backHomeBtn.layer.borderWidth=1;
        [_backHomeBtn addTarget:self action:@selector(tapBackHomeBtn ) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backHomeBtn;
}
- (NSString *)getNavigationTitle {
    return @"预约成功";
}

@end
