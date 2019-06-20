//
//  HYCommonService.h
//  TeamDevelop
//
//  Created by lish on 2019/6/5.
//  Copyright © 2019 develop. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ImagePickerControllerfFinshedCancle)(void);
typedef void (^ImagePickerControllerfFinshed)(NSArray <UIImage *>*photos);

@interface HYCommonService : NSObject

@property (nonatomic,copy) ImagePickerControllerfFinshed finshedBlock;

@property (nonatomic,copy) ImagePickerControllerfFinshedCancle cacleBlock;


+ (instancetype)shareInstance;

+ (BOOL)isNeedLogin;

+ (void)needLogin;

+ (void)swicthTabRootController;

+ (void)switchLoginController;

+ (void)hy_navigationPushController:(UIViewController *)controller;

- (void)presentPhotoPickerWithMaxCount:(NSInteger)maxCount finshedHandle:(ImagePickerControllerfFinshed)finshedHandle cancleHandle:(ImagePickerControllerfFinshedCancle)cancaleHandle;

@end

NS_ASSUME_NONNULL_END
