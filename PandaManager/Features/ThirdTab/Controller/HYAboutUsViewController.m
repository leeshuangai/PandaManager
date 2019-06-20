//
//  HYAboutUsViewController.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYAboutUsViewController.h"

@interface HYAboutUsViewController ()
@property (nonatomic,strong) UIView *whiteBg;
@property (nonatomic,strong) UIImageView *bg;
@end

@implementation HYAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
    
    [self.view addSubview:self.bg];
    [self.view addSubview:self.whiteBg];
    
    [self.whiteBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT);
    }];
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT+20);
        make.left.right.bottom.equalTo(self.view);
    }];
}
-(UIView *)whiteBg {
    if (!_whiteBg) {
        _whiteBg = [[UIView alloc]init];
        _whiteBg.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
    }
    return _whiteBg;
}
- (UIImageView *)bg {
    if (!_bg) {
        _bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_icon"]];
        _bg.contentMode =UIViewContentModeScaleAspectFill;
    }
    return _bg;
}
- (NSString *)getNavigationTitle {
    return @"关于我们";
}


@end
