//
//  HYClassroomCustomView.h
//  Panda
//
//  Created by lish on 2019/5/30.
//  Copyright © 2019 panda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYClassroomCustomView,HYClassroomModel;
NS_ASSUME_NONNULL_BEGIN
typedef void (^HYClassroomCustomViewHandle)(HYClassroomCustomView *view);
@interface HYClassroomCustomView : UIView
@property (nonatomic,copy) HYClassroomCustomViewHandle deleteHandle;
@property (nonatomic,copy) HYClassroomCustomViewHandle handle;
@property (nonatomic,assign) BOOL isSelected;
- (instancetype)initWithModel:(HYClassroomModel *)model;

- (void)tapSelected;
@end

NS_ASSUME_NONNULL_END
