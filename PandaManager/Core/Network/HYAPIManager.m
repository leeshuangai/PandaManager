//
//  HYAPIManager.m
//  Panda
//
//  Created by lish on 2019/5/29.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYAPIManager.h"
#import "AFNetworkReachabilityManager.h"
@implementation HYAPIManager

+ (instancetype)shareInstance {
    
    static dispatch_once_t once;
    static id __singleton__;
    dispatch_once( &once, ^{
        __singleton__ = [[self alloc] init];
        
    } );
    
    return __singleton__;
    
}
- (void)postWithCompletion:(void(^)(BOOL success,id data,NSString *error))completion {
    
    [HYHUD showLoadingHUD];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self checkNetWorkTransWithCompletion:^(BOOL success) {
            
            [HYHUD hiddenLoadingHUD];
            
            if (success) {
                if (completion) {
                    completion(YES,nil,@"");
                }
            }else {
                if (completion) {
                    completion(NO,nil,@"网络连接错误，请稍后再试");
                }
            }
        }];
    });
    
   
   
 
}

- (void)postNoHudWithCompletion:(void(^)(BOOL success,id data,NSString *error))completion {
    
   // [HYHUD showLoadingHUD];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self checkNetWorkTransWithCompletion:^(BOOL success) {
            
          //  [HYHUD hiddenLoadingHUD];
            
            if (success) {
                if (completion) {
                    completion(YES,nil,@"");
                }
            }else {
                if (completion) {
                    completion(NO,nil,@"网络连接错误，请稍后再试");
                }
            }
        }];
    });
 
    
}




- (void)checkNetWorkTransWithCompletion:(void(^)(BOOL success))completion {
    
    AFNetworkReachabilityManager *managerAF = [AFNetworkReachabilityManager sharedManager];
    [managerAF startMonitoring];
   __block BOOL networkStatus = NO;
    [managerAF setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知的网络类型");
            
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"通过WIFI上网");
                networkStatus = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"通过3G/4G上网");
                networkStatus = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"当前网络不可达");
                
                break;
        }
       
            if (completion) {
                completion(networkStatus);
            }
        
    }];
    
    
}

@end
