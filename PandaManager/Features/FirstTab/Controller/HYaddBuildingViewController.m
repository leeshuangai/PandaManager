//
//  HYaddBuildingViewController.m
//  PandaManager
//
//  Created by yingqiu.tian on 2019/6/16.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYaddBuildingViewController.h"
#import "HYArrowTextCustomView.h"
#import "HYUIService.h"
@interface HYaddBuildingViewController ()
@property (nonatomic,strong) UIView *avatarView;
@property (nonatomic,strong) UIImageView *avatarImg;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSArray *placeholderArr;
@end

@implementation HYaddBuildingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    self.arr = @[@"教学楼", @"楼层数",@"每层教室数量", @"开发时间"];
    self.placeholderArr = @[@"请填入教学楼名称", @"请填入楼层数",@"请填入教室数量", @"请填写开放时间"];
    // Do any additional setup after loading the view.
    [self initUI];
}
-(void)initUI {
    [self.view addSubview: self.avatarView];
    self.avatarImg= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_img_default"]];
    [self.avatarView addSubview:self.avatarImg];
    UIButton *btn = [HYUIService initUIButtonWithTitle:@"上传" titleColor:[UIColor whiteColor] font: kSystemFontSize(14)] ;
    btn.backgroundColor = COLOR_JJ_BLUE_THEME;
    btn.layer.cornerRadius = 20;

    [self.view addSubview:btn];
    
    for (int i = 0; i < self.arr.count; i++) {
       HYArrowTextCustomView *view1 = [[HYArrowTextCustomView alloc] initWithName:self.arr[i] placeholder:self.placeholderArr[i] icon:@""];
        [self.view addSubview: view1];
        view1.tag = i;
        view1.backgroundColor = COLOR_JJ_BLUE_THEME;
        [view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(kAdaptedHeight(50));
            make.left.equalTo(self.view.mas_left).offset(-15);
            make.right.equalTo(self.view.mas_right).offset(15);
            make.top.equalTo(self.avatarView.mas_bottom).offset(10+i*kAdaptedHeight(50));
        }];
    }
    [self.avatarImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAdaptedWidth(80));
        make.height.mas_equalTo(kAdaptedHeight(80));
        make.left.equalTo(self.avatarView.mas_left).offset(15);
        make.top.equalTo(self.avatarView.mas_top).offset(20);
    }];
    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAdaptedWidth(300));
        make.height.mas_equalTo(kAdaptedHeight(40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-70);
    }];

}
-(UIView *)avatarView {
    if (!_avatarView) {
        _avatarView= [[UIView alloc] init];
        _avatarView.frame = CGRectMake(0, kNAVBARHEIGHT, kScreenWidth, kAdaptedHeight(150));
        _avatarView.backgroundColor = [UIColor whiteColor];
    }
    return _avatarView;
}
- (NSString *)getNavigationTitle {
    return @"添加教学楼";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
