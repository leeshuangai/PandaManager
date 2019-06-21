//
//  HYOrderClassroomViewController.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYOrderClassroomViewController.h"
#import "HYSubmitButton.h"
#import "HYNoOrderRecordTableCell.h"
#import "HYNullTabTableCell.h"
#import "HYOrderClassroomFooterView.h"
#import "HYOrderClassroomHeaderView.h"
#import "HYDatePickerView.h"
#import "HYCommitOrderViewController.h"
#import "HYOrderRecordCell.h"
#import "HYSubcribeInfoViewController.h"
@interface HYOrderClassroomViewController ()<UITableViewDelegate,UITableViewDataSource,HYOrderRecordCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HYSubmitButton *submitBtn;
@property (nonatomic,strong) HYOrderClassroomHeaderView *headerView;
@property (nonatomic,strong) NSArray <HYOrderModel *> *orderModels;
@property (nonatomic,strong) HYDatePickerView *datePickerView;
@property (nonatomic,strong) HYOrderModel *orderModel;

@end

@implementation HYOrderClassroomViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
   
    [self initUI];
    [self queryOrderRecordWithDate:[NSDate date]];
}
-(void)queryOrderRecordWithDate:(NSDate *)date  {
    

    [[HYAPIManager shareInstance]querySubcribeClassroomRecordWithDate:date classroomName:self.classroomModel.name Completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        if (success) {
            
            
            self.orderModels = [NSArray arrayWithArray:data];
        }else{
            
        }
        [self.tableView reloadData];
        
        
    }];
}
- (void)tapDatePikerView {
    
    [self.datePickerView show];
    
    
}

-(void)initUI {
    
   
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT);
        make.left.right.bottom.equalTo(self.view);
        
    }];
   
}
- (void)hy_orderRecordCell:(HYOrderRecordCell *)cell didCancleOrder:(HYOrderModel *)order {
    
    
    [[HYAPIManager shareInstance]queryCancleSubcribeClassroomWithModel:order classroomName:self.classroomModel.name Completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        if (success) {
            
            
            self.orderModels = [NSArray arrayWithArray:data];
        }else{
            
        }
        [self.tableView reloadData];
    }];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.orderModels.count) {
       
        HYSubcribeInfoViewController *vc = [[HYSubcribeInfoViewController alloc]init];
       
        vc.orderModel = [self.orderModels objectAtIndex:indexPath.item];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.orderModels.count) {
        HYOrderRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYOrderRecordCell"];
        if (cell) {

            
            cell.orderModel =self.orderModels[indexPath.item];
            cell.delegate = self;
            
        }
        return cell;
    }else {
        HYNullTabTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYNullTabTableCell"];
        if (cell) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //cell.orderModels =self.orderModels;
            
        }
        return cell;
    }
   
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     
    if (self.orderModels.count) {
      return kAdaptedHeight(150);
    }else{
        return kAdaptedHeight(120);
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kAdaptedHeight(240);
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (self.orderModels.count) {
        return self.orderModels.count;
    }else{
        return 1;
    }
}
- (void)setOrderModels:(NSArray<HYOrderModel *> *)orderModels {
    
    _orderModels = orderModels;
    
   
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNAVBARHEIGHT, kScreenWidth, kScreenHeight-kNAVBARHEIGHT-kAdaptedHeight(65)) style:UITableViewStylePlain];
        _tableView.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[HYOrderRecordCell class] forCellReuseIdentifier:@"HYOrderRecordCell"];
     
        [_tableView registerNib:[UINib nibWithNibName:@"HYNullTabTableCell" bundle:nil]  forCellReuseIdentifier:@"HYNullTabTableCell"];
    }
    return _tableView;
}

- (HYOrderClassroomHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HYOrderClassroomHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kAdaptedHeight(240))];
        @weakify(self);
        _headerView.handle = ^{
            @strongify(self);
            [self tapDatePikerView];
        };
    }
    return _headerView;
}

- (HYDatePickerView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [HYDatePickerView datePickerViewWithTitle:@"选择预约日期" minDate:[NSDate date]];
        @weakify(self);
        _datePickerView.selectedDateCompletion = ^(NSString * _Nonnull selectedDateFormart, NSDate * _Nonnull selectedDate) {
            @strongify(self);
            self.headerView.date = [NSString stringFromDate:selectedDate formart:@"yyyy年MM月dd日"];
            self.orderModel.orderDate = self.headerView.date;
            [self queryOrderRecordWithDate:selectedDate];
        };
    }
    return _datePickerView;


}


- (void)setClassroomModel:(HYClassroomModel *)classroomModel {
    _classroomModel =classroomModel;
    
    self.headerView.classroomModel = _classroomModel;

    self.orderModel = [[HYOrderModel alloc]init];
    self.orderModel.orderClassroom = _classroomModel.name;
    self.orderModel.classFloor = _classroomModel.floor;
    self.orderModel.orderDate = [NSString stringFromDate:[NSDate date] formart:@"yyyy年MM月dd日"];
    
    
}

- (NSString *)getNavigationTitle {
    return @"预约情况";
}
@end
