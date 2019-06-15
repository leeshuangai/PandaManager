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
#import "HYHaveOrderRecordTableCell.h"
#import "HYOrderClassroomFooterView.h"
#import "HYOrderClassroomHeaderView.h"
#import "HYDatePickerView.h"
#import "HYCommitOrderViewController.h"
@interface HYOrderClassroomViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HYSubmitButton *submitBtn;
@property (nonatomic,strong) HYOrderClassroomFooterView *footerView;
@property (nonatomic,strong) HYOrderClassroomHeaderView *headerView;
@property (nonatomic,strong) NSArray <HYOrderModel *> *orderModels;
@property (nonatomic,strong) HYDatePickerView *datePickerView;
@property (nonatomic,strong) HYDatePickerView *startDatePickerView;
@property (nonatomic,strong) HYDatePickerView *endDatePickerView;
@property (nonatomic,strong) HYOrderModel *orderModel;
@end

@implementation HYOrderClassroomViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    
   
    [self initUI];
    [self queryOrderRecord];
}
-(void)queryOrderRecord {
    
//    [[HYAPIManager shareInstance]queryOrderRecordWithOrderClassName:self.classroomModel.name floor:self.classroomModel.floor  completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
//        if (success) {
//            self.orderModels = [NSArray arrayWithArray:data];
//            [self.tableView reloadData];
//        }else{
//            [HYHUD showSuccessHUD:error];
//        }
//    }];
}
- (void)tapDatePikerView {
    
    [self.datePickerView show];
    
    
}

- (void)tapSubmitBtn {
    
    NSString *startTime = [[self.classroomModel.openTime componentsSeparatedByString:@"-"].firstObject stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *endTime = [[self.classroomModel.openTime componentsSeparatedByString:@"-"].lastObject stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    
    if (!self.footerView.startTime.isNotBlank || !self.footerView.endTime.isNotBlank) {
        [HYHUD showSuccessHUD:@"请选择预约时间"];
        return;
    }
    else if ([self.footerView.startTime stringByReplacingOccurrencesOfString:@":" withString:@""].intValue >= [self.footerView.endTime stringByReplacingOccurrencesOfString:@":" withString:@""].intValue ){
          [HYHUD showSuccessHUD:@"请正确选择开始时间和结束时间"];
        return;
    }
   
   else if (startTime.intValue > [self.footerView.startTime stringByReplacingOccurrencesOfString:@":" withString:@""].intValue) {
        [HYHUD showSuccessHUD:@"请正确选择开始时间"];
        return;
    }
    
   else if (endTime.intValue < [self.footerView.endTime stringByReplacingOccurrencesOfString:@":" withString:@""].intValue) {
 
        [HYHUD showSuccessHUD:@"请正确选择结束时间"];
       return;
   }
    
    self.orderModel.orderTime = [NSString stringWithFormat:@"%@-%@",self.footerView.startTime,self.footerView.endTime];
    HYCommitOrderViewController *vc = [[HYCommitOrderViewController alloc]init];
    
    vc.orderModel = self.orderModel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)initUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSAFEAREABOTTOM-20);
        make.height.mas_equalTo(kAdaptedHeight(40));
        make.width.mas_equalTo(kAdaptedWidth(300));
        make.centerX.equalTo(self.view);
        
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-20);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.orderModels.count) {
        HYHaveOrderRecordTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYHaveOrderRecordTableCell"];
        if (cell) {
            
            
            cell.orderModels =self.orderModels;
            
        }
        return cell;
    }else {
        HYNoOrderRecordTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYNoOrderRecordTableCell"];
        return cell;
    }
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return kAdaptedHeight(100);
    if (self.orderModels.count) {
        if (self.orderModels.count > 4) {
            return kAdaptedHeight(220)+kAdaptedHeight(30)*(self.orderModels.count-4);
        }else{
            return kAdaptedHeight(220);
        }
        
    }else {
        return kAdaptedHeight(100);
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     return kAdaptedHeight(104);
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return kAdaptedHeight(210);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNAVBARHEIGHT, kScreenWidth, kScreenHeight-kNAVBARHEIGHT-kAdaptedHeight(65)) style:UITableViewStylePlain];
        _tableView.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[HYHaveOrderRecordTableCell class] forCellReuseIdentifier:@"HYHaveOrderRecordTableCell"];
          [_tableView registerClass:[HYNoOrderRecordTableCell class] forCellReuseIdentifier:@"HYNoOrderRecordTableCell"];
    }
    return _tableView;
}
- (HYSubmitButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn  = [[HYSubmitButton alloc]init];
        _submitBtn.titleString = @"立即预约";
        _submitBtn.titleColor = COLOR_JJ_DEFAULT_WHITE;
        _submitBtn.backgroundColor = COLOR_JJ_BLUE_THEME;
        
        @weakify(self);
        _submitBtn.clickHandle = ^{
            @strongify(self);
            [self tapSubmitBtn];
        };
    }
    return _submitBtn;
}
- (HYOrderClassroomHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HYOrderClassroomHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kAdaptedHeight(220))];
        @weakify(self);
        _headerView.handle = ^{
            @strongify(self);
            [self tapDatePikerView];
        };
    }
    return _headerView;
}

- (HYOrderClassroomFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[HYOrderClassroomFooterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptedHeight(104))];
          @weakify(self);
        _footerView.tapEndBtnHandle = ^{
            @strongify(self);
            [self.endDatePickerView show];
        };
        _footerView.tapStartBtnHandle = ^{
             @strongify(self);
            [self.startDatePickerView show];
        };
    }
    return _footerView;
}
- (HYDatePickerView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [HYDatePickerView datePickerViewWithTitle:@"选择预约日期" minDate:[NSDate date]];
        @weakify(self);
        _datePickerView.selectedDateCompletion = ^(NSString * _Nonnull selectedDateFormart, NSDate * _Nonnull selectedDate) {
            @strongify(self);
            self.headerView.date = [NSString stringFromDate:selectedDate formart:@"yyyy年MM月dd日"];
            self.orderModel.orderDate = self.headerView.date;
            
        };
    }
    return _datePickerView;



}

-(HYDatePickerView *)endDatePickerView {
    if (!_endDatePickerView) {
        _endDatePickerView = [HYDatePickerView timeDatePickerViewWithTitle:@"选择预约开始时间"];
        @weakify(self);
        _endDatePickerView.selectedDateCompletion = ^(NSString * _Nonnull selectedDateFormart, NSDate * _Nonnull selectedDate) {
            @strongify(self);
            self.footerView.endTime = [NSString stringFromDate:selectedDate formart:@"HH:mm"];

        };
    }
    return _endDatePickerView;
}
-(HYDatePickerView *)startDatePickerView {
    if (!_startDatePickerView) {
        _startDatePickerView = [HYDatePickerView timeDatePickerViewWithTitle:@"选择预约开始时间"];
        @weakify(self);
        _startDatePickerView.selectedDateCompletion = ^(NSString * _Nonnull selectedDateFormart, NSDate * _Nonnull selectedDate) {
            @strongify(self);
             self.footerView.startTime = [NSString stringFromDate:selectedDate formart:@"HH:mm"];
            
        };
    }
    return _startDatePickerView;
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
    return @"预约教室";
}
@end
