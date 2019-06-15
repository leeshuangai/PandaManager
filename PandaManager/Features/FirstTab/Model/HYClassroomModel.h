//
//  HYClassroomModel.h
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYClassroomModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *openTime;
@property (nonatomic,copy) NSString *device;
@property (nonatomic,copy) NSString *seat;
@property (nonatomic,copy) NSString *floor;
@property (nonatomic,copy) NSString *closeTime;
@property (nonatomic,copy) NSString *flooorCount;
@property (nonatomic,copy) NSString *classroomCount;
@end

NS_ASSUME_NONNULL_END
