//
//  HYOrderModel.h
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYOrderModel : NSObject


@property (nonatomic,copy) NSString *orderId;

@property (nonatomic,copy) NSString *orderUserId;

@property (nonatomic,copy) NSString *className;

@property (nonatomic,copy) NSString *orderTime;

@property (nonatomic,copy) NSString *orderDate;

@property (nonatomic,copy) NSString *orderClassroom;

@property (nonatomic,copy) NSString *orderStatus;

@property (nonatomic,copy) NSString *classFloor;
@end

NS_ASSUME_NONNULL_END
