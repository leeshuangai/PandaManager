//
//  HYClassroomFloorCollectionCell.h
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYClassroomModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HYClassroomFloorCollectionCell : UICollectionViewCell

@property (nonatomic,copy) NSString *floor;

@property (nonatomic,assign) BOOL isSelectedRoom;

@end

NS_ASSUME_NONNULL_END
