//
//  HYBaseService.h
//  TeamDevelop
//
//  Created by lish on 2019/6/14.
//  Copyright © 2019 develop. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseService : NSObject


+ (void)userLoginHandleWithName:(NSString *)name password:(NSString *)password;



+ (void)userRegisterHandleWithName:(NSString *)name password:(NSString *)password commitPassword:(NSString *)commitPassword;


+ (void)useLogoutHandle;

@end

NS_ASSUME_NONNULL_END
