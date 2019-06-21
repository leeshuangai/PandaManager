//
//  HYClassroomFloorViewController.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYClassroomFloorViewController.h"
#import "HYClassroomFloorCollectionCell.h"
#import "HYClassromFloorCollectionHeaderView.h"
#import "HYClassromFloorCollectionFooterView.h"
#import "HYOrderClassroomViewController.h"
#import "HYAddClassroomFloorCollectionCell.h"
#import "HYCustomAlertView.h"


@interface HYClassroomFloorViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,assign) NSIndexPath *selectedIndex;

@property (nonatomic,strong) HYSubmitButton *submitBtn;

@end

@implementation HYClassroomFloorViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
   
    [self.view addSubview:self.collectionView];
     [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-kSAFEAREABOTTOM- kAdaptedHeight(20));
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth - kAdaptedWidth(60));
        make.height.mas_equalTo(kAdaptedHeight(45));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.submitBtn.mas_top);
        make.top.equalTo(self.view.mas_top).offset(kNAVBARHEIGHT);
    }];
    self.view.backgroundColor = COLOR_JJ_BACKGROUND;
}
#pragma mark event
- (void)tapAddBtnWithAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger floor = indexPath.section +1;

    [HYCustomAlertView alertViewWithDetail:[NSString stringWithFormat:@"确认%ld楼添加教室？",floor] cancleTitle:@"取消" commitTitle:@"确认" cancleHandle:^(HYCustomAlertView *alert) {
    } commitHandle:^(HYCustomAlertView *alert) {
        [alert dismissView];
       
        NSString *num = self.classroomModel.floorInfo[indexPath.section];
        
        NSMutableArray *numList = [NSMutableArray arrayWithArray:self.classroomModel.floorInfo];
        
        [numList replaceObjectAtIndex:indexPath.section withObject:[NSString stringWithFormat:@"%d",num.intValue+1]];
        
        
        self.classroomModel.floorInfo = numList.mutableCopy;
        
        [[HYAPIManager shareInstance]queryModifyClassrommWithModel:self.classroomModel completion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
            if (success) {
                self.classroomModel = data;
                [self.collectionView reloadData];
                [HYHUD showSuccessHUD:@"添加成功"];
            }else{
                [HYHUD showSuccessHUD:error];
            }
        }];
    }];
    
    
}


#pragma mark delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     NSString *num= self.classroomModel.floorInfo[indexPath.section];
    
    if (indexPath.item == num.intValue) {
        
        
        HYAddClassroomFloorCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYAddClassroomFloorCollectionCell"  forIndexPath:indexPath];
        
        @weakify(self);
        cell.tapAddHandle = ^{
            @strongify(self);
            [self tapAddBtnWithAtIndexPath:indexPath];
        };
        
        return cell;
    }else{
        
        HYClassroomFloorCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYClassroomFloorCollectionCell"  forIndexPath:indexPath];
        
        if (self.selectedIndex == indexPath) {
            cell.isSelectedRoom = YES;
        }else {
            cell.isSelectedRoom = NO;
        }

        if (indexPath.item+1 <10) {
            cell.floor = [NSString stringWithFormat:@"%ld0%ld",(long)indexPath.section+1,indexPath.item+1];
            
        }else {
            cell.floor = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section+1,indexPath.item+1];
        }
        
        
        
        
        return cell;
    }
   
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSString *num= self.classroomModel.floorInfo[section];
    
    return num.intValue + 1;
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.classroomModel.flooorCount.intValue;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

    self.selectedIndex = indexPath;
    [self.collectionView reloadData];
    
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HYClassromFloorCollectionHeaderView *header =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYClassromFloorCollectionHeaderView" forIndexPath:indexPath];
        
        NSArray *floors = @[@"一楼",@"二楼",@"三楼",@"四楼",@"五楼",@"六楼",@"七楼"];
        
        header.title = floors[indexPath.section];
        
        return header;
    }else {
        HYClassromFloorCollectionFooterView *footer =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HYClassromFloorCollectionFooterView" forIndexPath:indexPath];
    
        return footer;
    }
   
}
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat width = (kScreenWidth-kAdaptedWidth(30)-5*kAdaptedWidth(15))/4;
 
        layout.itemSize = CGSizeMake(width,kAdaptedHeight(30));
        
        layout.sectionInset = UIEdgeInsetsMake(0, kAdaptedWidth(15), 20, kAdaptedWidth(15));
       
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout.minimumLineSpacing = kAdaptedHeight(15);
        
        layout.minimumInteritemSpacing = kAdaptedWidth(15);
        
        layout.headerReferenceSize = CGSizeMake(kScreenWidth,kAdaptedHeight(40));
        
        layout.footerReferenceSize = CGSizeMake(kScreenWidth,kAdaptedHeight(20));
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, kNAVBARHEIGHT+15, kScreenWidth-kAdaptedWidth(30), kScreenHeight-kNAVBARHEIGHT-15) collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
     
        _collectionView.backgroundColor = COLOR_JJ_DEFAULT_WHITE;
        
        
          [_collectionView registerNib:[UINib nibWithNibName:@"HYAddClassroomFloorCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HYAddClassroomFloorCollectionCell"];
        
        [_collectionView registerClass:[HYClassroomFloorCollectionCell class] forCellWithReuseIdentifier:@"HYClassroomFloorCollectionCell"];
        
       
        [_collectionView registerClass:[HYClassromFloorCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYClassromFloorCollectionHeaderView"];
        
          [_collectionView registerClass:[HYClassromFloorCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HYClassromFloorCollectionFooterView"];
    }
    return _collectionView;
    
}
- (NSString *)getNavigationTitle {
    return self.classroomModel.name;
}


- (UIImage *)getCustomNavigationBarRightButtonImage {
    return [UIImage imageNamed:@"icon_delete_white"];
}
- (void)customNavigationBarRightButtonAction:(id)sender {
    
    if (self.selectedIndex) {
        NSString *text;
        if (self.selectedIndex.item+1 <10) {
              text = [NSString stringWithFormat:@"%ld0%ld",(long)self.selectedIndex.section+1,self.selectedIndex.item+1];
            
        }else {
            text = [NSString stringWithFormat:@"%ld%ld",(long)self.selectedIndex.section+1,self.selectedIndex.item+1];
        }
        
        [HYCustomAlertView alertViewWithDetail:[NSString stringWithFormat:@"确认删除%@教室？",text] cancleTitle:@"取消" commitTitle:@"确认" cancleHandle:^(HYCustomAlertView *alert) {
            
            
        } commitHandle:^(HYCustomAlertView *alert) {
            [alert dismissView];
            
            [[HYAPIManager shareInstance]postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
                if (success) {
                    [HYCustomAlertView alertViewWithDetail:@"删除该教室需要审核，以免影响预约该教室的用户，请耐心等待" cancleTitle:@"我知道了" cancleHandle:nil];
                }else{
                    [HYHUD showSuccessHUD:error];
                }
            }];
            
        }];
        
    }
    else{
        [HYHUD showSuccessHUD:@"请选择需要删除的教室"];
    }
}
- (HYSubmitButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [[HYSubmitButton alloc]init];
        _submitBtn.titleString = @"查看教室预约记录";
        @weakify(self);
        _submitBtn.clickHandle = ^{
            @strongify(self);
            HYOrderClassroomViewController *vc = [[HYOrderClassroomViewController alloc]init];
            vc.classroomModel = self.classroomModel;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        };
    }
    return _submitBtn;
}
@end
