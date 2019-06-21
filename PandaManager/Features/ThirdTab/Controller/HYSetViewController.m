//
//  HYSetViewController.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYSetViewController.h"
#import "HYPodfileTableViewCell.h"
#import "HYSubmitButton.h"
#import "HYLoginViewController.h"
#import "HYCustomAlertView.h"

@interface HYSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HYSubmitButton *submitBtn;
@end

@implementation HYSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
   
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
  
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth - kAdaptedWidth(76));
        make.height.mas_equalTo(kAdaptedHeight(40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-kSAFEAREABOTTOM-kAdaptedHeight(33));
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HYPodfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYPodfileTableViewCell"];
    NSArray *list = @[@"清除缓存",@"版本号"];
    if (cell) {
        
        cell.name = [list objectAtIndex:indexPath.item];
        
        if (indexPath.item == 1) {
            
            cell.detail = @"1.0";
        }
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAdaptedHeight(75);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    if (indexPath.item == 0) {
       
        [HYHUD showLoadingHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HYHUD hiddenLoadingHUD];
            [HYHUD showSuccessHUD:@"清除缓存完成"];
        });
    }
   
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (void)tapLogoutBtn {
    
    
    [[HYAPIManager shareInstance]queryUserLoginoutWithUserId:[HYUserManager shareInstance].currentUser.userId completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        if (success) {
            
            HYLoginViewController *loginvc = [[HYLoginViewController alloc]init];
            
            loginvc.isTab = @"1";
            
            [self presentViewController:loginvc animated:YES completion:nil];
            
        }
        
        [HYHUD showSuccessHUD:success?@"退出登录成功":error];
        
    }];
   
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNAVBARHEIGHT, kScreenWidth, kScreenHeight- kAdaptedHeight(150)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HYPodfileTableViewCell class] forCellReuseIdentifier:@"HYPodfileTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (HYSubmitButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [[HYSubmitButton alloc]init];
        
        _submitBtn.titleString = @"退出登录";
        @weakify(self);
        _submitBtn.clickHandle = ^{
            @strongify(self);
            [self tapLogoutBtn];
        };
        
    }
    return _submitBtn;
    
}
- (NSString *)getNavigationTitle {
    return @"设置";
}


@end
