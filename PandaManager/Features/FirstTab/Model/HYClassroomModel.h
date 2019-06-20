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
@property (nonatomic,copy) NSString *classroomId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,strong) NSData *imgData;
@property (nonatomic,copy) NSString *openTime;
@property (nonatomic,copy) NSString *device;
@property (nonatomic,copy) NSString *seat;
@property (nonatomic,copy) NSString *floor;
@property (nonatomic,copy) NSString *closeTime;
@property (nonatomic,copy) NSString *flooorCount;//楼层数量
@property (nonatomic,copy) NSString *classroomCount;//每楼层教室数量
@property (nonatomic,strong) NSArray *floorInfo;

@property (nonatomic,copy) NSString *orderTime;
@end

NS_ASSUME_NONNULL_END
