//
//  LLUser.h
//  YQD
//
//  Created by lish on 2018/9/18.
//  Copyright © 2018年 lish. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface HYUser : NSObject

/** 用户id 、手机号 */
@property (nonatomic,copy) NSString *userId;

/** 密码 */
@property (nonatomic,copy) NSString *password;

/** 用户id 、教工号 */
@property (nonatomic,copy) NSString *teachId;

/** 姓名 */
@property (nonatomic,copy) NSString *userName;

/** 院系 */
@property (nonatomic,copy) NSString *department;

/** 身份证号码 */
@property (nonatomic,copy) NSString *identityNumber;

/** 办公室 */
@property (nonatomic,copy) NSString *office;

/** 手机号 */
@property (nonatomic,copy) NSString *mobile;

/** 办公室电话 */
@property (nonatomic,copy) NSString *officeMobile;


@property (nonatomic,strong) NSData *avaterData;


@end
