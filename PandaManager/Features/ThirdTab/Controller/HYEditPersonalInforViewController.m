//
//  HYEditPersonalInforViewController.m
//  Panda
//
//  Created by lish on 2019/5/30.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYEditPersonalInforViewController.h"
#import "HYTextFieldView.h"
#import "HYSubmitButton.h"
@interface HYEditPersonalInforViewController ()

@property (nonatomic,strong) NSMutableArray *textFieldViews;
@property (nonatomic,strong) HYSubmitButton *submitBtn;
@end

@implementation HYEditPersonalInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth - kAdaptedWidth(76));
        make.height.mas_equalTo(kAdaptedHeight(40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-kSAFEAREABOTTOM-kAdaptedHeight(33));
    }];
}

- (void)initUI {
    
    self.textFieldViews = [NSMutableArray array];
    
    NSArray  *inforList = @[@"姓名",@"院系",@"身份证号",@"教工号",@"办公室",@"电话",@"办公室电话"];
    
    NSArray * userInfo = @[        [HYUserManager shareInstance].currentUser.userName?:@"请输入姓名",        [HYUserManager shareInstance].currentUser.department?:@"请输入院系",        [HYUserManager shareInstance].currentUser.identityNumber?:@"请输入身份证号",        [HYUserManager shareInstance].currentUser.teachId?:@"请输入教工号",        [HYUserManager shareInstance].currentUser.office?:@"请输入办公室",        [HYUserManager shareInstance].currentUser.mobile?:@"请输入电话",        [HYUserManager shareInstance].currentUser.officeMobile?:@"请输入办公室电话"].mutableCopy;
    
   __block CGFloat y = kNAVBARHEIGHT + 10;
    
    CGFloat height = kAdaptedHeight(50);
    
    CGFloat margin = 10;
    
    [inforList enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        HYTextFieldView *viewv = [[HYTextFieldView alloc]initWithTitle:inforList[idx] placeholder:userInfo[idx]];
        
        [self. view addSubview:viewv];
       
        y = (height+margin) * idx + (kNAVBARHEIGHT + 10);
        
        viewv.frame = CGRectMake(0, y, kScreenWidth, height);
        
        [self.textFieldViews addObject:viewv];
        
        if (![userInfo[idx]  containsString:@"请输入"]) {
            viewv.textField.text =userInfo[idx];
            
        }

    }];
    
    
}
- (void)tapSubmitBtn {
    
    HYUser *user =  [HYUserManager shareInstance].currentUser;
   
    [self.textFieldViews enumerateObjectsUsingBlock:^(HYTextFieldView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *text = obj.textField.text;
        switch (idx) {
            case 0:
                               if (text.isNotBlank)  user.userName = text;
                break;
            case 1:
                               if (text.isNotBlank)  user.department = text;
                break;
            case 2:
                               if (text.isNotBlank)  user.identityNumber = text;
                break;
            case 3:
                               if (text.isNotBlank)  user.teachId = text;
                break;
            case 4:
                               if (text.isNotBlank)  user.office = text;
                break;
            case 5:
                               if (text.isNotBlank)  user.mobile = text;
                break;
            case 6:
                               if (text.isNotBlank)  user.officeMobile = text;
                break;
          
        }
        
        
    }];
    
    [[HYAPIManager shareInstance]postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        if (success) {
            [[HYUserManager shareInstance]saveUserInfo:user
                                             completed:^(BOOL completed) {
                                                 
                                                 [HYHUD showSuccessHUD:@"修改成功"];
                                                 [self.navigationController popViewControllerAnimated:YES];
                                             }];
            
        }else {
            [HYHUD showSuccessHUD:error];
        }
    }];
   
    
    
}

- (HYSubmitButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn  = [[HYSubmitButton alloc]init];
        _submitBtn.titleString = @"保 存";
        @weakify(self);
        _submitBtn.clickHandle = ^{
            @strongify(self);
            [self tapSubmitBtn];
        };
    }
    return _submitBtn;
}
- (NSString *)getNavigationTitle {
    return @"个人信息";
}
@end
