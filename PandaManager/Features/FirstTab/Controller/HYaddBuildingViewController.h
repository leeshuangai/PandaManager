//
//  HYaddBuildingViewController.h
//  PandaManager
//
//  Created by yingqiu.tian on 2019/6/16.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYBaseViewController.h"
#import "HYClassroomModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HYaddBuildingViewController : HYBaseViewController

@property (nonatomic,strong) HYClassroomModel *classroomModel;

@property (nonatomic,copy) NSString *isEdit;

@end

NS_ASSUME_NONNULL_END
