//
//  HYAddClassroomFloorCollectionCell.h
//  PandaManager
//
//  Created by lish on 2019/6/19.
//  Copyright © 2019 develop. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HYAddClassroomFloorCollectionCellHandle) (void);
NS_ASSUME_NONNULL_BEGIN

@interface HYAddClassroomFloorCollectionCell : UICollectionViewCell

@property (nonatomic,copy) HYAddClassroomFloorCollectionCellHandle tapAddHandle;
@end

NS_ASSUME_NONNULL_END
