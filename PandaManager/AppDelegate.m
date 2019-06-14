//
//  AppDelegate.m
//  TeamDevelop
//
//  Created by lish on 2019/6/5.
//  Copyright © 2019 develop. All rights reserved.
//$(SRCROOT)/TeamDevelop/Core/Macro/AppPrefixHeader.pch

#import "AppDelegate.h"
#import "TabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [self saveUser];
    
    TabBarViewController *vc = [[TabBarViewController alloc]init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)saveUser {
    
    HYUser *user = [[HYUser alloc]init];
    user.userId = @"18845326754";
    user.teachId = @"20141234527";
    user.password = @"111111";
    user.userName = @"曾小雨";
    user.department = @"医学院";
    user.officeMobile = @"0812-2234320";
    user.office = @"励志楼203号";
    user.mobile = @"18845326754";
    user.identityNumber = @"510131197012042345";
    [[HYUserManager shareInstance]saveUserInfo:user completed:^(BOOL completed) {
        
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
