//
//  HYCommitOrderViewController.m
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYCommitOrderViewController.h"
#import "HYOrderSuccessViewController.h"
#import "HYSubmitButton.h"
@interface HYCommitOrderViewController ()

@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) UITextField *tf;

@property (nonatomic,strong) HYSubmitButton *orderBtn;
@end

@implementation HYCommitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)tapOrderBtn {
    if (!self.tf.text.isNotBlank ) {
        [HYHUD showSuccessHUD:@"请设置活动名称"];
        return;
    }
    self.orderModel.className =self.tf.text;
    
//    [[HYAPIManager shareInstance]queryOrderWithOrder:self.orderModel completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
//        if (success) {
//            HYOrderSuccessViewController *vc = [[HYOrderSuccessViewController alloc]init];
//            vc.orderModel = self.orderModel;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//            [HYHUD showSuccessHUD:error];
//        }
//    }];
    
   
}

- (void)setOrderModel:(HYOrderModel *)orderModel {
    _orderModel = orderModel;
    
    self.infoLabel.text = [NSString stringWithFormat:@"您好：%@\n\n您将预约的%@%@,预约时间%@%@请设置活动名称，再点击确认预约",[HYUserManager shareInstance].currentUser.userName.isNotBlank?[HYUserManager shareInstance].currentUser.userName:@"--",self.orderModel.orderClassroom,self.orderModel.classFloor,self.orderModel.orderDate,self.orderModel.orderTime];

}
- (void)initUI {
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.tf];
    [self.view addSubview:self.orderBtn];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT +kAdaptedHeight(40));
        make.left.equalTo(self.view).offset(kAdaptedWidth(15));
        make.right.equalTo(self.view.mas_right).offset(kAdaptedWidth(-15));
    }];
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).offset(kAdaptedHeight(40));
        make.left.equalTo(self.view).offset(kAdaptedWidth(15));
        make.right.equalTo(self.view.mas_right).offset(kAdaptedWidth(-15));
        make.height.mas_equalTo(kAdaptedHeight(40));
    }];
    
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-kSAFEAREABOTTOM-30);
        make.left.equalTo(self.view).offset(kAdaptedWidth(38));
        make.right.equalTo(self.view.mas_right).offset(kAdaptedWidth(-38));
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(kAdaptedHeight(40));
    }];
}
- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _infoLabel.font = kSystemFontSize(16);
        _infoLabel.numberOfLines =0;
    }
    return _infoLabel;
}
- (UITextField *)tf {
    if (!_tf) {
        _tf =[[UITextField alloc]init];
        _tf.placeholder = @" 请输入活动名称";
        _tf.backgroundColor = COLOR_JJ_BACKGROUND;
        _tf.layer.cornerRadius= 20;
        _tf.layer.masksToBounds = YES;
    }
    return _tf;
}
- (HYSubmitButton *)orderBtn {
    if (!_orderBtn) {
        _orderBtn   = [[HYSubmitButton alloc]init];
        _orderBtn.titleString = @"确认预约";
        @weakify(self);
        _orderBtn.clickHandle = ^{
            @strongify(self);
            [self tapOrderBtn];
        };
      
    }
    return _orderBtn;
}
- (NSString *)getNavigationTitle {
    return @"预约教室";
}

@end
