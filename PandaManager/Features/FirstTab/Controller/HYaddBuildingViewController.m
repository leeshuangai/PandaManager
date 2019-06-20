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
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) NSMutableArray <HYArrowTextCustomView *>*tfViews;
@property (nonatomic,strong) UIImage *selectImg;

@property (nonatomic,strong) UIButton *uploadBtn;
@end

@implementation HYaddBuildingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    self.arr = @[@"教学楼", @"楼层数",@"每层教室数量", @"开发时间"];
    self.placeholderArr = @[@"请填入教学楼名称", @"请填入楼层数",@"请填入教室数量", @"请填写开放时间 例如:06:00-21:00"];
    [self initUI];
}

- (void)queryAddClassroom {

    
    if (!self.selectImg) {
        [HYHUD showSuccessHUD:@"请上传教学楼图片"];
        return;
    }
  
    __block   BOOL status = YES;
    [self.tfViews enumerateObjectsUsingBlock:^(HYArrowTextCustomView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj.tf.text isNotBlank]) {
            [HYHUD showSuccessHUD:self.placeholderArr[idx]];
            status = NO;
            return ;
        }
        
    }];
    
    if (self.tfViews[1].tf.text.intValue < 1) {
        [HYHUD showSuccessHUD:@"楼层数不能为0"];
        return;
    }
    
    if (self.tfViews[2].tf.text.intValue < 1) {
        [HYHUD showSuccessHUD:@"每楼层教室数量不能为0"];
        return;
    }
    
    if (status) {
        
        HYClassroomModel *modle = [[HYClassroomModel alloc]init];
        modle.imgData = UIImageJPEGRepresentation(self.selectImg, 0.8);
        modle.name = self.tfViews[0].tf.text;
        modle.flooorCount = self.tfViews[1].tf.text;
        modle.classroomCount = self.tfViews[2].tf.text;
        modle.openTime = self.tfViews[3].tf.text;
        
        [[HYAPIManager shareInstance]queryAddClassromWithClassModel:modle completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
           
            if (success) {
                [HYHUD showSuccessHUD:@"添加成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [HYHUD showSuccessHUD:error];
            }
            
            
        }];
        
        
    }
    
    
    
}
-(void)initUI {
    [self.view addSubview: self.avatarView];
    self.btn1 = [HYUIService initUIButtonWithTitle:@"" titleColor:[UIColor redColor] font: kSystemFontSize(14)] ;
    [self.btn1 setImage:[UIImage imageNamed:@"icon_img_default"] forState:0];
    [self.btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.avatarView addSubview:self.btn1];
    
    self.uploadBtn = [HYUIService initUIButtonWithTitle:@"上传" titleColor:[UIColor whiteColor] font: kSystemFontSize(14)] ;
     self.uploadBtn .backgroundColor = COLOR_JJ_BLUE_THEME;
     self.uploadBtn .layer.cornerRadius = 20;
    [ self.uploadBtn  addTarget:self action:@selector(queryAddClassroom) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview: self.uploadBtn];
    
    [self.btn1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAdaptedWidth(80));
        make.height.mas_equalTo(kAdaptedHeight(80));
        make.left.equalTo(self.avatarView.mas_left).offset(15);
        make.top.equalTo(self.avatarView.mas_top).offset(20);
    }];
    [ self.uploadBtn  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAdaptedWidth(300));
        make.height.mas_equalTo(kAdaptedHeight(40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-70);
    }];
    
    
    self.tfViews = [NSMutableArray array];
    for (int i = 0; i < self.arr.count; i++) {
       HYArrowTextCustomView *view1 = [[HYArrowTextCustomView alloc] initWithName:self.arr[i] placeholder:self.placeholderArr[i] icon:@""];
       
        [self.view addSubview: view1];
        view1.tag = i;
       // view1.backgroundColor = COLOR_JJ_BLUE_THEME;
        if (i ==2 || i == 1) {
            view1.tf.keyboardType = UIKeyboardTypeNumberPad;
        }
        [self.tfViews addObject:view1];
        [view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kAdaptedHeight(57));
            make.left.equalTo(self.view.mas_left).offset(-15);
            make.right.equalTo(self.view.mas_right).offset(15);
            make.top.equalTo(self.avatarView.mas_bottom).offset(10+i*kAdaptedHeight(57));
        }];
    }
    
   

}
-(void)btnAction:(UIButton *)btn{
     [self presentPhotoPiker];
}
-(UIView *)avatarView {
    if (!_avatarView) {
        _avatarView= [[UIView alloc] init];
        _avatarView.frame = CGRectMake(0, kNAVBARHEIGHT, kScreenWidth, kAdaptedHeight(120));
        _avatarView.backgroundColor = [UIColor whiteColor];
    }
    return _avatarView;
}
- (void )presentPhotoPiker {
    
    [[HYCommonService shareInstance]presentPhotoPickerWithMaxCount:1 finshedHandle:^(NSArray<UIImage *> * _Nonnull photos) {
        [self.btn1 setImage:photos.firstObject forState:0];
        self.selectImg = photos.firstObject;
    } cancleHandle:^{
        
    }];
    
}
- (NSString *)getNavigationTitle {
    return @"添加教学楼";
}

- (void)setIsEdit:(NSString *)isEdit {
    _isEdit = isEdit;
    if ([_isEdit isEqualToString:@"1"]) {
       
        [self.uploadBtn setTitle:@"删除" forState:0];
        
        [self.tfViews enumerateObjectsUsingBlock:^(HYArrowTextCustomView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.tf.enabled = NO;
            
        }];
        
        self.avatarImg.image =[UIImage imageWithData:self.classroomModel.imgData];
        self.tfViews[0].tf.text = self.classroomModel.name;
        self.tfViews[1].tf.text = self.classroomModel.flooorCount;
        self.tfViews[2].tf.text = @"--";
        self.tfViews[3].tf.text=self.classroomModel.openTime;
        
    }else {
        [self.uploadBtn setTitle:@"上传" forState:0];
        
    }
}

@end
