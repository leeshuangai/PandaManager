//
//  TPFileHelper.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPFileHelper : NSObject
/**
 *  @brief 从ResourceBundle中加载资源
 *  @param name 文件名
 *  @param type 类型
 */
+ (NSString *)bundleFilePathForResourceName:(NSString *)name type:(NSString *)type;


/**
 *  @brief 加载json格式资源文件
 *  @param fileName 文件名称
 
 *  @default 默认从Resource.bundle加载json
 */
+ (id)loadingJsonResourceWithFileName:(NSString *)fileName;


/**
 加载本地mainbundle json格式文件

 @param fileName 文件名称
 @return return value description
 */
+ (id)loadingMainBundleJsonResouJsonResourceWithFileName:(NSString *)fileName;

@end
