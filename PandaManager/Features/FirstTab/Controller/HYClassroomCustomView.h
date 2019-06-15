//
//  HYClassroomCustomView.h
//  Panda
//
//  Created by lish on 2019/5/30.
//  Copyright © 2019 panda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYClassroomCustomView;
NS_ASSUME_NONNULL_BEGIN
typedef void (^HYClassroomCustomViewHandle)(HYClassroomCustomView *view);
@interface HYClassroomCustomView : UIView
@property (nonatomic,copy) HYClassroomCustomViewHandle handle;

- (instancetype)initWithIcon:(NSString *)icon name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
