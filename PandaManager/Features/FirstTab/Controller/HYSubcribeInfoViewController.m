//
//  HYSubcribeInfoViewController.m
//  PandaManager
//
//  Created by lish on 2019/6/20.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYSubcribeInfoViewController.h"
#import "HYSubcribeInfoTableCell.h"
@interface HYSubcribeInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;


@property (nonatomic,strong) NSArray *userInfo;
@property (nonatomic,strong) NSArray *classroomInfo;

@end

@implementation HYSubcribeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.userInfo = @[@"姓名：苑洁",@"院系：医学院",@"身份证号码：510131197****2345",@"教工号：20171234527",@"办公室：励志楼203号",@"电话：19945326754",@"办公室电话：0812-3361218"];
//  
//    self.classroomInfo = @[@"用途：2017届护士1班基础课",@"时间：10:00～12:00",@"教室：博学楼201室"];
//    
//    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT);
    }];
    
    
}
- (void)setOrderModel:(HYOrderModel *)orderModel {
    _orderModel = orderModel;
    
    self.userInfo = @[_orderModel.orderUserName?:@"--",_orderModel.orderNameDepartment?:@"--",_orderModel.orderIdentityNumber?:@"--",@"--",_orderModel.orderOffice?:@"--",_orderModel.orderMobile?:@"--",_orderModel.orderOfficeMobile?:@"--"];
    
    self.classroomInfo = @[_orderModel.className?:@"--",_orderModel.orderTime?:@"--",[NSString stringWithFormat:@"%@%@",_orderModel.orderClassroom,_orderModel.classFloor]];
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYSubcribeInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"refuse"];
    if (indexPath.section == 0) {
       
         cell.label.text = self.userInfo[indexPath.item];
    }else{
        cell.label.text = self.classroomInfo[indexPath.item];
    }
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAdaptedHeight(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kAdaptedHeight(80);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.userInfo.count;
    }else{
         return self.classroomInfo.count;
    }
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *text;
    if (section == 0) {
        text = @"个人信息";
    }else{
        text = @"预约信息";
    }
    
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = COLOR_JJ_BACKGROUND;
    header.frame = CGRectMake(0, 0, kScreenWidth, kAdaptedHeight(80));
    
    UILabel *label = [HYUIService initUILabelWithText:text textColor:COLOR_JJ_TEXT_MAIN font:kSystemFontSize(14)];
    [header addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = kAdaptedHeight(20);
    label.layer.masksToBounds = YES;
    label.textColor = COLOR_JJ_THEME;
    label.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header);
        make.top.equalTo(header.mas_top).offset(kAdaptedHeight(27));
        make.bottom.equalTo(header.mas_bottom).offset(kAdaptedHeight(-15));
        make.width.mas_equalTo(kScreenWidth - kAdaptedWidth(100));
    }];
    return header;
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        
      _tableView =  [HYUIService initUITableViewWithFrame:self.view.frame style:UITableViewStylePlain backgroundColor:COLOR_JJ_BACKGROUND];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"HYSubcribeInfoTableCell" bundle:nil] forCellReuseIdentifier:@"refuse"];
    }
    return _tableView;
}
- (NSString *)getNavigationTitle {
    return @"预约信息";
}

@end
