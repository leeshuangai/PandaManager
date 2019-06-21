//
//  HYRegisterViewController.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYRegisterViewController.h"
#import "HYTextFieldIconView.h"
#import "HYSubmitButton.h"
#import "HYLoginViewController.h"
#import "TabBarViewController.h"
#import "UIImage+Gradient.h"
#import "NSString+Regular.h"
@interface HYRegisterViewController ()

@property (nonatomic,strong) UIScrollView *scrollewBg;

@property (nonatomic,strong) UIImageView *bg;

@property (nonatomic,strong) UIImageView *headerBg;

@property (nonatomic,strong) UILabel *headerLabel;

@property (nonatomic,strong) HYTextFieldIconView *userNameTextView;

@property (nonatomic,strong) HYTextFieldIconView *userPasswordTextView;

@property (nonatomic,strong) HYTextFieldIconView *submitUserPasswordTextView;

@property (nonatomic,strong) UIButton *loginBtn;

@property (nonatomic,strong) HYSubmitButton *registerBtn;

@end

@implementation HYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
 
    
}
- (void)tapLoginBtn {
    HYLoginViewController *vc = [[HYLoginViewController alloc]init];
    vc.isTab = @"1";
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (void)tapRegisterBtn {
    
    if (![self.userNameTextView.textField.text checkPhoneNumber]) {
        [HYHUD showSuccessHUD:@"请输入正确手机号"];
        return;
    }
    else if (![self.userPasswordTextView.textField.text isEqualToString:self.submitUserPasswordTextView.textField.text]){
        
        [HYHUD showSuccessHUD:@"两次密码输入不相同"];
        return;
    }
    
    else if (self.userPasswordTextView.textField.text.length < 6){
        [HYHUD showSuccessHUD:@"输入密码至少6位"];
        return;
        
    }else {

        [[HYAPIManager shareInstance]queryUserRegisterWithUserId:self.userNameTextView.textField.text password:self.userPasswordTextView.textField.text  completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
            
            if (!success) {
                [HYHUD showSuccessHUD:error];
            }
            else {
                

                [HYCommonService swicthTabRootController];
                
                [HYHUD showSuccessHUD:@"注册成功"];
            }
        }];
        
    }
    
    
}
- (void)initUI {
    
    [self.view addSubview:self.scrollewBg];
    [self.scrollewBg addSubview:self.bg];
    [self.scrollewBg addSubview:self.headerBg];
    [self.scrollewBg addSubview:self.headerLabel];
    [self.scrollewBg addSubview:self.userNameTextView];
    [self.scrollewBg addSubview:self.userPasswordTextView];
    [self.scrollewBg addSubview:self.submitUserPasswordTextView];
    [self.scrollewBg addSubview:self.loginBtn];
    [self.scrollewBg addSubview:self.registerBtn];
    
    [self.scrollewBg mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(kScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(-kSTATUSBARHEIGHT);
        make.left.equalTo(self.view.mas_left);
    }];
    [self.bg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollewBg.mas_top);
        make.left.right.equalTo(self.scrollewBg);
        make.height.mas_equalTo(kNAVBARHEIGHT);
    }];

    [self.headerBg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollewBg);
        make.top.equalTo(self.bg.mas_bottom).offset(-30);
        make.height.mas_equalTo(kAdaptedHeight(kAdaptedHeight(250)));

    }];
//
    [self.headerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerBg.mas_bottom);
        make.left.equalTo(self.scrollewBg.mas_left).offset(20);

    }];

    [self.userNameTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerLabel.mas_bottom).offset(20);
        make.left.equalTo(self.scrollewBg.mas_left).offset(30);
        make.right.equalTo(self.scrollewBg.mas_right).offset(-20);
        make.height.mas_equalTo(65);
    }];

    [self.userPasswordTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTextView.mas_bottom);
        make.left.equalTo(self.scrollewBg.mas_left).offset(30);
        make.right.equalTo(self.scrollewBg.mas_right).offset(-20);
        make.height.mas_equalTo(65);
    }];
//
//
    [self.submitUserPasswordTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userPasswordTextView.mas_bottom);
        make.left.equalTo(self.scrollewBg.mas_left).offset(30);
        make.right.equalTo(self.scrollewBg.mas_right).offset(-20);
        make.height.mas_equalTo(65);
    }];

    [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.submitUserPasswordTextView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];

    [self.registerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(kAdaptedWidth(220));
    }];

   _bg .image = [UIImage createGradientImageWithSize:CGSizeMake(kScreenWidth, kNAVBARHEIGHT) startColor:HEX(0x6D23FF) endColor:HEX(0x6D23FF)];

    [self.scrollewBg mas_updateConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.registerBtn.mas_bottom).offset(kAdaptedHeight(60));
    }];
    
    [self.view layoutIfNeeded];
}
- (UIScrollView *)scrollewBg {
    if (!_scrollewBg) {
        _scrollewBg = [[UIScrollView alloc]init];
        _scrollewBg.backgroundColor = [UIColor whiteColor];
        _scrollewBg.bounces = NO;
    }
    return _scrollewBg;
}
- (UIImageView *)headerBg {
    if (!_headerBg) {
        _headerBg = [[UIImageView alloc]init];
        _headerBg.image = [UIImage imageNamed:@"icon_headerIcon"];
        _headerBg.contentMode =UIViewContentModeScaleAspectFit;
    }
    return _headerBg;
}


- (HYTextFieldIconView *)userNameTextView {
    if (!_userNameTextView) {
        _userNameTextView = [[HYTextFieldIconView alloc]initWithPlaceholder:@"输入手机号码" icon:@"icon_phone"];
        _userNameTextView.textField.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    return _userNameTextView;
}
- (HYTextFieldIconView *)userPasswordTextView {
    if (!_userPasswordTextView) {
        _userPasswordTextView = [[HYTextFieldIconView alloc]initWithPlaceholder:@"请输入密码" icon:@"icon_code"];
        _userPasswordTextView.isSecure = YES;
       
    }
    return _userPasswordTextView;
}
- (HYTextFieldIconView *)submitUserPasswordTextView {
    if (!_submitUserPasswordTextView) {
        _submitUserPasswordTextView = [[HYTextFieldIconView alloc]initWithPlaceholder:@"请再次输入密码" icon:@"icon_code"];
        _submitUserPasswordTextView.isSecure = YES;
        
    }
    return _submitUserPasswordTextView;
}
- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]init];
        
        _headerLabel.text = @"欢迎注册";
    }
    return _headerLabel;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton  alloc]init];
       
        [_loginBtn setTitle:@"登录" forState:0];
        [_loginBtn setTitleColor:COLOR_JJ_TEXT_MAIN forState:0];
        [_loginBtn addTarget:self action:@selector(tapLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
- (HYSubmitButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [[HYSubmitButton alloc]init];
        _registerBtn.titleString = @"注册账号";
        
        @weakify(self);
        _registerBtn.clickHandle = ^{
            @strongify(self);
            [self tapRegisterBtn];
        };
    }
    return _registerBtn;
}

- (UIImageView *)bg {
    if (!_bg) {
        _bg = [[UIImageView alloc]init];
    }
    return _bg;
}
- (BOOL)getCustomNavigationBarHidden {
    return YES;
}

@end
