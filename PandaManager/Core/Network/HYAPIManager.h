//
//  HYAPIManager.h
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYAPIManager : NSObject

+ (instancetype)shareInstance;


- (void)postWithCompletion:(void(^)(BOOL success,id data,NSString *error))completion;


- (void)postNoHudWithCompletion:(void(^)(BOOL success,id data,NSString *error))completion;


- (void)postNoHudNoAfterWithCompletion:(void(^)(BOOL success,id data,NSString *error))completion;

@end

NS_ASSUME_NONNULL_END
