//
//  HYOrderClassroomFooterView.h
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^HYOrderClassroomFooterViewHandle)(void);
@interface HYOrderClassroomFooterView : UIView
@property (nonatomic,copy) HYOrderClassroomFooterViewHandle tapStartBtnHandle;
@property (nonatomic,copy) HYOrderClassroomFooterViewHandle tapEndBtnHandle;

@property (nonatomic,copy) NSString *startTime;
@property (nonatomic,copy) NSString *endTime;

@end

NS_ASSUME_NONNULL_END
