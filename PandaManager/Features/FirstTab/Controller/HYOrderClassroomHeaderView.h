//
//  HYOrderClassroomHeaderView.h
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYClassroomModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^HYOrderClassroomHeaderViewHandle)(void);

@interface HYOrderClassroomHeaderView : UIView

@property (nonatomic,copy) HYOrderClassroomHeaderViewHandle handle;
@property (nonatomic,strong) HYClassroomModel *classroomModel;
@property (nonatomic,copy) NSString *date;
@end

NS_ASSUME_NONNULL_END
