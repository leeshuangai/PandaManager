//
//  NavigationController.m
//  UINav+UITab
//
//  Created by lish on 2017/7/20.
//  Copyright © 2017年 lish. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController



- (void)viewDidLoad {
    [super viewDidLoad];

}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断self.childViewControllers是不是拿到所有子控制器
    if (self.childViewControllers.count > 0) {
        
        //当视图推送时隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    //子控制器通过这个方法推送视图
    [super pushViewController:viewController animated:animated];
}





@end
