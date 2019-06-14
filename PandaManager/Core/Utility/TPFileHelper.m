//
//  TPFileHelper.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPFileHelper.h"

@implementation TPFileHelper

+ (NSString *)bundleFilePathForResourceName:(NSString *)name type:(NSString *)type {
    NSString * budlePath = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
    NSBundle *resourcePathBundle = [NSBundle bundleWithPath:budlePath];
    return [resourcePathBundle pathForResource:name ofType:type];
}


+ (id)loadingJsonResourceWithFileName:(NSString *)fileName {
    
    if (!fileName.isNotBlank) {
        return nil;
    }
    
    NSString *filePath = [TPFileHelper bundleFilePathForResourceName:fileName type:@"json"];
    NSData *capacityData = [NSData dataWithContentsOfFile:filePath];
    NSError *parseError;
    id result = [NSJSONSerialization JSONObjectWithData:capacityData options:0 error:&parseError];
    if (parseError) {
            return nil;
    } else {
            return result;
    }
}
+ (id)loadingMainBundleJsonResouJsonResourceWithFileName:(NSString *)fileName {
    
    if (!fileName.isNotBlank) {
        return nil;
    }
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"json"]];
    
    NSError *parseError;
    id result = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&parseError];
    if (parseError) {
        return nil;
    } else {
        return result;
    }
    
}
@end
