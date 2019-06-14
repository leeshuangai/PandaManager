//
//  LLBaseViewController.m
//  YQD
//
//  Created by lish on 2018/9/17.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "HYBaseViewController.h"
#define KNavigationDefaultTintColor HEX(0x999999)
@interface HYBaseViewController ()



@end

@implementation HYBaseViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_JJ_DEFAULT_WHITE;

    
}

#pragma mark - NavigationBar
- (BOOL)getCustomNavigationBar {
    return YES;
}
- (BOOL)getStatusBarIsLight {
    return STATUS_BAR_LIGHT;
}
- (BOOL)getNavigationBarEdgePanBack {
    return YES;
}
- (BOOL)getCustomNavigationBarHairLineHidden {
    return NO;
}
- (UIColor *)getNavigationTitleColor {
    return NAV_TITLE_COLOR;
}

- (UIColor *)getNavigationBarBackgroundColor {
    return NAV_BACKGROUND_COLOR;
}

- (UIColor *)getCustomNavigationBarLeftButtonTintColor {
    return NAV_LEFT_TINT_COLOR;
}

- (UIColor *)getCustomNavigationBarRightButtonTintColor {
    return COLOR_JJ_DEFAULT_WHITE;
}

- (UIColor *)getNavigationBarBackButtonColor {
    return NAV_BACK_COLOR;
    
}



@end
