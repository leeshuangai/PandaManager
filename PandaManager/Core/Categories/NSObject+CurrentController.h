//
//  NSObject+CurrentController.h
//  TopjetPicking
//
//  Created by lish on 2017/8/21.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CurrentController)

/**
 获取当前控制器

 @return 返回控制器
 */
+ (UIViewController *)getCurrentVC;

+ (UINavigationController *)currentNC;

+ (UINavigationController *)getCurrentNCFrom:(UIViewController *)vc;
@end
