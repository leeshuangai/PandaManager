//
//  HYLoginViewController.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYLoginViewController.h"
#import "HYTextFieldIconView.h"
#import "HYSubmitButton.h"
#import "HYRegisterViewController.h"
#import "TabBarViewController.h"
#import "UIImage+Gradient.h"
@interface HYLoginViewController ()
@property (nonatomic,strong) UIScrollView *scrollewBg;

@property (nonatomic,strong) UIImageView *bg;

@property (nonatomic,strong) UIImageView *headerBg;

@property (nonatomic,strong) UIImageView *headerBgIcon;

@property (nonatomic,strong) UILabel *headerBgTitle;

@property (nonatomic,strong) UILabel *headerLabel;

@property (nonatomic,strong) HYTextFieldIconView *userNameTextView;

@property (nonatomic,strong) HYTextFieldIconView *userPasswordTextView;

@property (nonatomic,strong) HYSubmitButton *loginBtn;

@property (nonatomic,strong) UIButton *registerBtn;

@end

@implementation HYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}
- (void)tapRegisterBtn {
    HYRegisterViewController *vc = [[HYRegisterViewController alloc]init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (void)tapLoginBtn {
    
    if (self.userNameTextView.textField.text.isNotBlank && self.userPasswordTextView.textField.text.isNotBlank) {
        
        
        [[HYAPIManager shareInstance]queryUserLoginWithUserId:self.userNameTextView.textField.text password:self.userPasswordTextView.textField.text
                                                   completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
           
            if (!success) {
                [HYHUD showSuccessHUD:error];
            }
            else {
                
               
                
                CATransition *trans = [[CATransition alloc] init];
                trans.type = kCATransitionPush;
                trans.subtype = kCATransitionFromRight;
                trans.duration = 0.25;
                [[UIApplication sharedApplication].keyWindow.layer addAnimation:trans forKey:nil];
                [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarViewController alloc]init];
                
                [HYHUD showSuccessHUD:@"登录成功"];
            }
        }];
        
    }else {
        [HYHUD showSuccessHUD:@"请正确输入正确手机号或密码"];
    }
    
    
}
- (void)initUI {
     [self.view addSubview:self.scrollewBg];
        [self.scrollewBg addSubview:self.bg];
    [self.scrollewBg addSubview:self.headerBg];

   // [self.view addSubview:self.headerBgTitle];
    [self.scrollewBg addSubview:self.headerLabel];
    [self.scrollewBg addSubview:self.userNameTextView];
    [self.scrollewBg addSubview:self.userPasswordTextView];
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
   
    [self.headerBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollewBg);
        make.top.equalTo(self.bg.mas_bottom).offset(-30);
        make.height.mas_equalTo(kAdaptedHeight(250));
        
    }];

    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerBg.mas_bottom);
        make.left.equalTo(self.scrollewBg.mas_left).offset(20);
        
    }];
    
    [self.userNameTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerLabel.mas_bottom).offset(20);
        make.left.equalTo(self.scrollewBg.mas_left).offset(30);
        make.right.equalTo(self.scrollewBg.mas_right).offset(-20);
        make.height.mas_equalTo(65);
    }];
    
    [self.userPasswordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTextView.mas_bottom);
        make.left.equalTo(self.scrollewBg.mas_left).offset(30);
        make.right.equalTo(self.scrollewBg.mas_right).offset(-20);
        make.height.mas_equalTo(65);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userPasswordTextView.mas_bottom).offset(40);
        make.centerX.equalTo(self.scrollewBg);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(kAdaptedWidth(220));
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(40);
        make.centerX.equalTo(self.scrollewBg);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
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


- (UIImageView *)bg {
    if (!_bg) {
        _bg = [[UIImageView alloc]init];
    }
    return _bg;
}

- (UIImageView *)headerBg {
    if (!_headerBg) {
        _headerBg = [[UIImageView alloc]init];
        _headerBg.image = [UIImage imageNamed:@"icon_headerIcon"];
    }
    return _headerBg;
}
- (UIImageView *)headerBgIcon {
    if (!_headerBgIcon) {
        _headerBgIcon = [[UIImageView alloc]init];
        _headerBgIcon.image = [UIImage imageNamed:@"resource_icon"];
    }
    return _headerBgIcon;
}

- (UILabel *)headerBgTitle {
    if (!_headerBgTitle) {
        _headerBgTitle = [[UILabel alloc]init];
        _headerBgTitle.textColor = COLOR_JJ_DEFAULT_WHITE;
        _headerBgTitle.font = kBoldSystemFontSize(20);
        _headerBgTitle.textAlignment = NSTextAlignmentCenter;
        _headerBgTitle.text = @"攀大找教室学校端";
    }
    return _headerBgTitle;
}
- (HYTextFieldIconView *)userPasswordTextView {
if (!_userPasswordTextView) {
     _userPasswordTextView = [[HYTextFieldIconView alloc]initWithPlaceholder:@"请输入密码" icon:@"icon_code"];
     _userPasswordTextView.isSecure = YES;
    }
    return _userPasswordTextView;
}
- (HYTextFieldIconView *)userNameTextView {
    if (!_userNameTextView) {
        _userNameTextView = [[HYTextFieldIconView alloc]initWithPlaceholder:@"输入手机号码" icon:@"icon_phone"];
    _userNameTextView.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _userNameTextView;
}
- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]init];

        _headerLabel.text = @"欢迎登录";
    }
    return _headerLabel;
}

- (HYSubmitButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[HYSubmitButton  alloc]init];
        _loginBtn.titleString = @"登录";
        @weakify(self);
        _loginBtn.clickHandle = ^{
            @strongify(self);
            [self tapLoginBtn];
        };
    }
    return _loginBtn;
}
- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册账号" forState:0];
        [_registerBtn setTitleColor:COLOR_JJ_TEXT_MAIN forState:0];
        [_registerBtn addTarget:self action:@selector(tapRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}
- (BOOL)getCustomNavigationBarHidden {
    return YES;
}



@end
