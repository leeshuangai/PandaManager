//
//  HYPersonalInforViewController.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYPersonalInforViewController.h"
#import "HYEditPersonalInforViewController.h"
#import "HYPersonalInforCell.h"
#import "HYAvaterCustomCell.h"
@interface HYPersonalInforViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *userInfo;

@end

@implementation HYPersonalInforViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLOR_JJ_BACKGROUND;
    self.tableView.backgroundColor = COLOR_JJ_BACKGROUND;
    self.userInfo = [NSMutableArray array];
    NSArray *inforList = @[@"名称",@"账号"];
    
    NSArray * userInfo = @[@"攀大找教室学校端",[HYUserManager shareInstance].currentUser.userId ].mutableCopy;
    
    [inforList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSString *info = [NSString stringWithFormat:@"%@ : %@",obj,[userInfo objectAtIndex:idx]];
        
        [self.userInfo addObject:info];
    }];
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
  
}

- (void )presentPhotoPiker {
    
    [[HYCommonService shareInstance]presentPhotoPickerWithMaxCount:1 finshedHandle:^(NSArray<UIImage *> * _Nonnull photos) {
        
        [HYUserManager shareInstance].currentUser.avaterData = UIImageJPEGRepresentation(photos.firstObject, 0.8);
        
        [[HYUserManager shareInstance] saveUserInfo:[HYUserManager shareInstance].currentUser completed:nil];
        
        [self.tableView reloadData];
        

        
        
    } cancleHandle:^{
        
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        HYAvaterCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYAvaterCustomCell"];
        cell.selectedHandle = ^{
            
            [self presentPhotoPiker];
            
        };
        
        cell.avaterData = [HYUserManager shareInstance].currentUser.avaterData;
        
        return cell;
        
    }else{
       
        HYPersonalInforCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYPersonalInforCell"];
        cell.name = [self.userInfo objectAtIndex:indexPath.item-1];
        
        return cell;
        
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return kAdaptedHeight(120);
    }else{
         return kAdaptedHeight(60);
    }
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
       return 3;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNAVBARHEIGHT+kAdaptedHeight(10), kScreenWidth, kScreenHeight-kNAVBARHEIGHT-kAdaptedHeight(10)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.tableHeaderView = [[UIView alloc]init];
        [_tableView registerClass:[HYPersonalInforCell class] forCellReuseIdentifier:@"HYPersonalInforCell"];
        
          [_tableView registerClass:[HYAvaterCustomCell class] forCellReuseIdentifier:@"HYAvaterCustomCell"];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (NSString *)getNavigationTitle {
    return @"个人信息";
}

@end
