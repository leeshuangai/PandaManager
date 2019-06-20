//
//  HYPodfileViewController.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYPodfileViewController.h"
#import "HYPodfileTableViewCell.h"
#import "HYSetViewController.h"
#import "HYAboutUsViewController.h"
#import "HYContactServiceViewController.h"
#import "HYPersonalInforViewController.h"
@interface HYPodfileViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *avatarImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *mottoLabel;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *headerImg;
@end

@implementation HYPodfileViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self blindName];
    [self obtainAvataerData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerImg];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.avatarImg];
    [self.view addSubview:self.titleLabel];

    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kSTATUSBARHEIGHT+21);
        make.width.height.mas_equalTo(kAdaptedWidth(80));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kSTATUSBARHEIGHT+112);
    }];
}
- (void)obtainAvataerData {
    if (  [HYUserManager shareInstance].currentUser.avaterData) {
        _avatarImg.image  = [UIImage imageWithData: [HYUserManager shareInstance].currentUser.avaterData];
    }else{
        _avatarImg.image  = [UIImage imageNamed:@"resource_icon"];
    }
}
- (void)blindName {
    
    NSString *name = [HYUserManager shareInstance].currentUser.userName;
    NSString *depart = [HYUserManager shareInstance].currentUser.department;
    if (name.isNotBlank && depart.isNotBlank) {
        name = [NSString stringWithFormat:@"您好,%@的%@",depart,name];
    }else if (name.isNotBlank){
        name = [NSString stringWithFormat:@"您好,%@",name];
    }else {
        name = @"您好,--";
    }
    _nameLabel.text = name;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HYPodfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYPodfileTableViewCell"];
    NSArray *list = @[@"资料",@"联系客服",@"关于我们",@"设置"];
    if (cell) {
        
        cell.name = [list objectAtIndex:indexPath.item];
        
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAdaptedHeight(75);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [HYCommonService needLogin];
    
    NSArray *list = @[@"HYPersonalInforViewController",@"HYContactServiceViewController",@"HYAboutUsViewController",@"HYSetViewController"];
    
    
    
    UIViewController *vc = [[NSClassFromString([list objectAtIndex:indexPath.item]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kAdaptedHeight(260), kScreenWidth, kScreenHeight-kAdaptedHeight(260)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HYPodfileTableViewCell class] forCellReuseIdentifier:@"HYPodfileTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UIImageView *)headerImg {
    if (!_headerImg) {
       _headerImg= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_header"]];
        _headerImg.frame = CGRectMake(0, 0, kScreenWidth, kAdaptedHeight(260));
    }
    return _headerImg;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"攀大找教室学校端";
        _titleLabel.font = kBoldSystemFontSize(18);
        _titleLabel.textColor = COLOR_JJ_DEFAULT_WHITE;
    }
    return _titleLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
       
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kBoldSystemFontSize(18);
        _nameLabel.textColor = COLOR_JJ_DEFAULT_WHITE;
        [self blindName];
    }
    return _nameLabel;
}
- (UIImageView *)avatarImg {
    if (!_avatarImg ) {
        _avatarImg = [[UIImageView alloc]init];
        CALayer * layer = [_avatarImg layer];
        layer.borderColor = [[UIColor whiteColor] CGColor];
        layer.borderWidth = 1.0f;
        _avatarImg.layer.cornerRadius  = kAdaptedWidth(40);
        _avatarImg.layer.masksToBounds = YES;
      
        [self obtainAvataerData];
    }
    return _avatarImg;

}


- (UILabel *)mottoLabel {
    if (!_mottoLabel) {
        _mottoLabel = [[UILabel alloc]init];
        _mottoLabel.text = @"笑着面对人生，别太多幻想";
        _mottoLabel.font = kSystemFontSize(16);
        _mottoLabel.textColor = COLOR_JJ_DEFAULT_WHITE;
    }
    return _mottoLabel;
}
- (BOOL)getCustomNavigationBarHidden {
    return YES;
}
@end
