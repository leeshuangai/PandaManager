//
//  HYFirstTabViewController.m
//  TeamDevelop
//
//  Created by lish on 2019/6/14.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYFirstTabViewController.h"
#import "HYClassroomModel.h"
#import "HYClassroomCustomView.h"
#import "HYClassroomFloorViewController.h"
#import "HYOrderClassroomViewController.h"
#import "HYUIService.h"
#import "HYaddBuildingViewController.h"
#import "HYCustomAlertView.h"
@interface HYFirstTabViewController ()
@property (nonatomic,strong) UIScrollView *scrollewBg;
@property (nonatomic,strong) UIImageView *headerImg;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) NSArray *classroomList;
@end

@implementation HYFirstTabViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scrollewBg .mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
  
}
- (void)queryClassroomList {
    
    [[HYAPIManager shareInstance]queryObtainClassromListWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        if (success) {
           
            self.classroomList = [NSArray arrayWithArray:data];
            [self initClassroomUI];
            
        }else{
       
            [HYHUD showSuccessHUD:error];
        }
            [self.scrollewBg.mj_header endRefreshing];
        
    }];
    
}
- (void)initUI {
    
    
    [self.view addSubview:self.scrollewBg];
    [self.scrollewBg addSubview:self.headerImg];
    [self.scrollewBg addSubview:self.contentView];
    [self.scrollewBg addSubview:self.titleLabel];
    [self.scrollewBg addSubview:self.detailLabel];
    
    [self.scrollewBg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT);
        make.left.equalTo(self.view.mas_left);
    }];
    [self.headerImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kAdaptedHeight(225));
        make.top.equalTo(self.scrollewBg.mas_top);
        make.left.equalTo(self.view.mas_left);
    }];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImg.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(kAdaptedWidth(15));
        make.right.equalTo(self.view.mas_right).offset(kAdaptedWidth(-15));
        make.height.mas_equalTo(kAdaptedHeight(360)+kAdaptedHeight(30));
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollewBg);
        make.top.equalTo(self.headerImg.mas_top).offset(kAdaptedHeight(25));
    }];

    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollewBg);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kAdaptedHeight(19));
    }];
   
    
   // [self initClassroomUI];
}

- (void)initClassroomUI {
    [self.contentView removeAllSubviews];
    int count = 3; // 每行按钮的数量为 3
    CGFloat btnWidth = (kScreenWidth-kAdaptedWidth(30)) / count;  //宽
    CGFloat btnHeight = kAdaptedHeight(120); //高
    for (int i = 0; i < self.classroomList.count+1; i++) {
        int row = i / count; // 行
        int col = i % count; // 列
        if (i == self.classroomList.count) {
            UIButton *btn = [HYUIService initUIButtonWithTitle:@"" titleColor:[UIColor redColor] font: kSystemFontSize(14)] ;
            [btn setImage:[UIImage imageNamed:@"icon_plus"] forState:0];
            [self.contentView addSubview: btn];
            btn.frame = CGRectMake(col * btnWidth, row * btnHeight+10, btnWidth, btnHeight);
            
            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headerImg.mas_bottom).offset(20);
                make.left.equalTo(self.view.mas_left).offset(kAdaptedWidth(15));
                make.right.equalTo(self.view.mas_right).offset(kAdaptedWidth(-15));
                make.bottom.equalTo(btn.mas_bottom).offset(0);
            }];
            [btn addTarget:self
                    action:@selector(BtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
        }else {
            HYClassroomModel *model = [self.classroomList objectAtIndex:i];
            HYClassroomCustomView *view = [[HYClassroomCustomView alloc]initWithModel:model];
            view.tag = 100+i;
            @weakify(self);
           
            
            view.handle = ^(HYClassroomCustomView * _Nonnull view) {
                @strongify(self);
                [self tapCustomView:view];
            };
            
            view.deleteHandle = ^(HYClassroomCustomView * _Nonnull view) {
                
                NSInteger index = view.tag - 100;
               
                [HYCustomAlertView alertViewWithDetail:@"确定删除该教学楼" cancleTitle:@"暂不" commitTitle:@"确定" cancleHandle:^(HYCustomAlertView *alert) {
                    
                } commitHandle:^(HYCustomAlertView *alert) {
                    [alert dismissView];
                    [[HYAPIManager shareInstance]queryDeleteClassromWithClassModel:self.classroomList[index] completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
                       
                        if (success) {
                            [HYHUD showSuccessHUD:@"删除成功"];
                            self.classroomList = [NSArray arrayWithArray:data];
                            [self initClassroomUI];
                        }else{
                            [HYHUD showSuccessHUD:error];
                        }
                    }];
                }];
                
            };
            view.frame = CGRectMake(col * btnWidth, row * btnHeight+10, btnWidth, btnHeight);
            [self.contentView addSubview:view];
        }
        
    }
    [self.scrollewBg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kAdaptedHeight(60));
    }];
    
    
    [self.view layoutIfNeeded];
}
- (void)BtnClick:(UIButton *)btn
{
    [HYCommonService needLogin];
    
    HYaddBuildingViewController *vc = [[HYaddBuildingViewController alloc] init];
    [self.navigationController pushViewController:vc animated: YES];
}
- (UIScrollView *)scrollewBg {
    if (!_scrollewBg) {
        _scrollewBg = [[UIScrollView alloc] init];
        _scrollewBg.backgroundColor = [UIColor whiteColor];
        @weakify(self);
        _scrollewBg.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self queryClassroomList];
            
        }];
    }
     return _scrollewBg;
}

- (UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"resource_banner"]];
    }
    return _headerImg;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.shadowOffset = CGSizeMake(0, 0); //(0,0)时是四周都有阴影
        _contentView.layer.shadowRadius = 3.5;
        _contentView.layer.shadowColor = COLOR_JJ_TEXT_MAIN.CGColor;
        _contentView.layer.shadowOpacity = 0.2;
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"找教室";
        _titleLabel.font = kBoldSystemFontSize(20);
        _titleLabel.textColor = COLOR_JJ_DEFAULT_WHITE;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = kSystemFontSize(18);
        _detailLabel.textColor = COLOR_JJ_DEFAULT_WHITE;
        _detailLabel.text = @"预约空教室方便快捷";
    }
    return _detailLabel;
}
- (void)tapCustomView:(HYClassroomCustomView *)view {
    
    [HYCommonService needLogin];
    
    NSInteger index = view.tag - 100;
    
    HYClassroomModel *model = self.classroomList[index];
    HYClassroomFloorViewController *vc = [[HYClassroomFloorViewController alloc]init];
    vc.classroomModel = model;
    [self.navigationController pushViewController:vc animated:YES];
  
}

- (NSString *)getNavigationTitle {
    return @"首页";
}
- (UIImage *)getCustomNavigationBarRightButtonImage {
    return [UIImage imageNamed:@"icon_edit-1"];
}
- (void)customNavigationBarRightButtonAction:(id)sender {
    
    if ([HYCommonService isNeedLogin]) {
        return;
    }
    
    [self.contentView .subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[HYClassroomCustomView class]]) {
            
            
            HYClassroomCustomView *view = obj;
            [view tapSelected];
            
        }
    }];
    
}
@end
