//
//  BulgeTabBarController.m
//  MCTabBarController
//
//  Created by caohouhong on 2018/12/7.
//  Copyright © 2018年 caohouhong. All rights reserved.
//  

#import "BulgeTabBarController.h"
#import "ViewController.h"
#import "NavigationController.h"
#import "HYFirstTabViewController.h"
#import "HYThirdTabViewController.h"
#import "HYSecondTabViewController.h"
@interface BulgeTabBarController ()<MCTabBarControllerDelegate>

@end

@implementation BulgeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //选中时的颜色
    self.mcTabbar.tintColor = COLOR_JJ_THEME;
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    self.mcTabbar.translucent = NO;
    
    self.mcTabbar.position = MCTabBarCenterButtonPositionBulge;
    self.mcTabbar.centerImage = [UIImage imageNamed:@"tabbar_scan"];
    self.mcDelegate = self;
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//添加子控制器
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addChildrenViewController:[[HYFirstTabViewController alloc] init] andTitle:@"商品管理" andImageName:@"tabbar_product_sel"];
    //中间这个不设置东西，只占位
    [self addChildrenViewController:[[HYSecondTabViewController alloc] init] andTitle:@"" andImageName:@""];
    
    [self addChildrenViewController:[[HYThirdTabViewController alloc] init] andTitle:@"门店管理" andImageName:@"tabbar_shop_sel"];

}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    // 选中的颜色由tabbar的tintColor决定
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:imageName];
    childVC.title = title;
    
    NavigationController *baseNav = [[NavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
}

// 使用MCTabBarController 自定义的 选中代理
- (void)mcTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 1){
       // [self rotationAnimation];
    }else {
       // [self.mcTabbar.centerBtn.layer removeAllAnimations];
    }
}

//旋转动画
- (void)rotationAnimation{
    if ([@"key" isEqualToString:[self.mcTabbar.centerBtn.layer animationKeys].firstObject]){
        return;
    }
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [self.mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}

@end
