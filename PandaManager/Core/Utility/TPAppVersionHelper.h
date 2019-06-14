//
//  TPAppVersionHelper.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/8/11.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPAppVersionHelper : NSObject

/** app Scheme */
+ (NSString*) appUrlScheme;

/** app BundleId */
+ (NSString*) appBundleId;

/** app uuid */
+ (NSString*) uuid;

/** app版本号 */
+ (NSString*) appVersion;

/** 操作系统版本号 */
+ (NSString*) osVersion;

/** 设备 */
+ (NSString*) deviceInfo;


/**
 设备+操作系统版本号

 @return return value description
 */
+ (NSString*) deviceInfoWithOsVersion;

/** 判断是否第一次安装 */
+ (BOOL)isFirstInstall;

/** 更新安装状态 */
+ (void)updateInstallStatus:(BOOL)status;

/** 获取沙盒中存储的应用版本号 */
+ (NSString *)currentSandBoxVersion;

/** 存储当前应用版本号 */
+ (void)saveCurrentVersion;

/** 判断是否是新版本 */
+ (BOOL)isNewVersion;


@end
