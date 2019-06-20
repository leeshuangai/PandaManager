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


/** 姓名 */
@property (nonatomic,copy) NSString *orderUserName;

/** 院系 */
@property (nonatomic,copy) NSString *orderNameDepartment;

/** 身份证号码 */
@property (nonatomic,copy) NSString *orderIdentityNumber;

/** 办公室 */
@property (nonatomic,copy) NSString *orderOffice;

/** 手机号 */
@property (nonatomic,copy) NSString *orderMobile;

/** 办公室电话 */
@property (nonatomic,copy) NSString *orderOfficeMobile;


@property (nonatomic,strong) NSData *orderAvaterData;


@end

NS_ASSUME_NONNULL_END
