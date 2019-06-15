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
@interface HYClassroomFloorViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HYClassroomFloorViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = COLOR_JJ_BACKGROUND;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYClassroomFloorCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYClassroomFloorCollectionCell"  forIndexPath:indexPath];
    

    cell.floor = [NSString stringWithFormat:@"%ld0%ld",(long)indexPath.section+1,indexPath.item+1];
    
    return cell;
    
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.classroomModel.classroomCount.intValue;
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.classroomModel.flooorCount.intValue;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYOrderClassroomViewController *vc = [[HYOrderClassroomViewController alloc]init];
    self.classroomModel.floor = [NSString stringWithFormat:@"%ld0%ld",(long)indexPath.section+1,indexPath.item+1];
    vc.classroomModel = self.classroomModel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
        
        
        [_collectionView registerClass:[HYClassroomFloorCollectionCell class] forCellWithReuseIdentifier:@"HYClassroomFloorCollectionCell"];
        
       
        [_collectionView registerClass:[HYClassromFloorCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYClassromFloorCollectionHeaderView"];
        
          [_collectionView registerClass:[HYClassromFloorCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HYClassromFloorCollectionFooterView"];
    }
    return _collectionView;
    
}
- (NSString *)getNavigationTitle {
    return self.classroomModel.name;
}
@end
