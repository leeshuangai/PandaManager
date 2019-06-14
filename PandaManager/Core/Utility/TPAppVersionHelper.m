//
//  TPAppVersionHelper.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/8/11.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPAppVersionHelper.h"

static NSString *const TPInstallStatusKey = @"TPInstallStatusKey";

static NSString *const TPCurrentVersionPrimaryKey = @"TPCurrentVersionPrimaryKey";

#define TPUserDefault [NSUserDefaults standardUserDefaults]

@implementation TPAppVersionHelper
+ (NSString*) uuid {
    NSString* uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    return uuid;
}
+ (NSString *)appUrlScheme {
    NSString * urlScheme = nil;
    
    NSArray * schemes    = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    
    for (NSDictionary * scheme in schemes) {
        NSString * identifier       = [scheme objectForKey:@"CFBundleURLName"];
         if (identifier && [identifier isEqualToString:[TPAppVersionHelper appBundleId]]) {
            NSArray * items         = [scheme objectForKey:@"CFBundleURLSchemes"];
            if (items && items.count) {
                urlScheme           = [items objectAtIndex:0];
            }
        }
    }
    return urlScheme;
}

+ (NSString*) appBundleId {
    NSString * bundleId = nil;
    
    bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    
    DLog(@"%@", bundleId);
    return bundleId;
}

+ (NSString*) appVersion {
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (NSString*) osVersion {
    NSString* osVersion = [[UIDevice currentDevice] systemVersion];
    return osVersion;
}

+ (NSString*) deviceInfo {
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}
+ (NSString *) deviceInfoWithOsVersion {
    
    return [[[self deviceInfo]stringByAppendingString:@" "]stringByAppendingString:[self osVersion]];
}
+ (BOOL)isFirstInstall {
    
     return ![TPUserDefault boolForKey:TPInstallStatusKey];
    
}
+ (void)updateInstallStatus:(BOOL)status {
    [TPUserDefault setBool:status forKey:TPInstallStatusKey];
    [TPUserDefault synchronize];
}


+ (NSString *)currentSandBoxVersion {
    return [TPUserDefault valueForKey:TPCurrentVersionPrimaryKey];
}

+ (void)saveCurrentVersion {
    
    NSString *newVersion = [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleShortVersionString"];
    
    [TPUserDefault setValue:newVersion
                     forKey:TPCurrentVersionPrimaryKey];
    
    [TPUserDefault synchronize];
}

+ (BOOL)isNewVersion {
    
    NSString *cut = [self appVersion];
    NSString *pre = [self currentSandBoxVersion];
    if ([cut isEqualToString:pre]) {
        return NO;
    } else {
        return YES;
    }
}
@end
