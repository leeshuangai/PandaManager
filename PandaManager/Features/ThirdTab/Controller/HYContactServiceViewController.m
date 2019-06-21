//
//  HYContactServiceViewController.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYContactServiceViewController.h"

@interface HYContactServiceViewController ()
@property (nonatomic,strong) UILabel *serviceLabel;
@end

@implementation HYContactServiceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_JJ_BACKGROUND;
    
    [self.view addSubview:self.serviceLabel];
    
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT +10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kAdaptedHeight(50));
        
    }];
}

- (UILabel *)serviceLabel {
    if (!_serviceLabel) {
        _serviceLabel = [[UILabel alloc]init];
        _serviceLabel.text = @"    客服电话：0812-2234618";
        _serviceLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _serviceLabel.font = kSystemFontSize(16);
        _serviceLabel.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
         _serviceLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
           
            UIWebView * webView = [[UIWebView alloc] init];
            
            [[UIApplication sharedApplication].keyWindow addSubview:webView];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"0812-2234618"]]]];
        
        }];
        [_serviceLabel addGestureRecognizer:tap];
       
    }
    return _serviceLabel;
}
- (NSString *)getNavigationTitle {
    return @"联系客服";
}
@end
