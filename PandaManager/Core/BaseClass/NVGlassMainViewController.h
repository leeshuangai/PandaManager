//
//  NVGlassMainViewController.h
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NVNavigationBarButtonImageTextSpace         3.0f
#define NVNavigationBarTintColorDelta               -0.2f
#define NVNavigationBarButtonDistanceToEdge         12.0f
#define NVNavigationBarButtonDefaultTintColor       [UIColor lightGrayColor]
#define NVNavigationBackImage @"icon_back"

@interface NVPageNavigationBar : UIView

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIButton* leftButton;
@property (nonatomic, strong) UIButton* rightButton;

@end

/**
 设置导航栏样式抽象类
 */
@interface NVGlassMainViewController : UIViewController

/**
 传递信息
 */
@property (nonatomic, strong) id kid;

/**
 自定义导航视图，若使用系统默认的NavigationBar，customNavigationBar则为nil
 */
@property (nonatomic, strong) NVPageNavigationBar* pageNavigationBar;

/**
 是否使用默认导航栏
 默认：NO 使用系统导航
 
 @return NO 使用系统导航；YES 使用自定义导航
 */
- (BOOL) getCustomNavigationBar;

/**
 设置状态栏样式
 
 @return 默认NO：黑色
 */
- (BOOL) getStatusBarIsLight;

/**
 子类设置NavigationBar标题
 
 @return 标题
 */
- (NSString*) getNavigationTitle;

/**
 子类设置NavigationBar标题颜色
 
 @return 颜色
 */
- (UIColor*) getNavigationTitleColor;

/**
 子类设置NavigationBar背景色
 
 @return 背景色
 */
- (UIColor*) getNavigationBarBackgroundColor;

/**
 子类设置NavigationBar标题属性
 
 @return 属性字典
 */
- (NSDictionary*) getNavigationTitleTextAttributes;

/**
 返回按钮采用系统默认，还是自定义图片的返回按钮
 默认：NO 采用自定义图片
 
 @return BOOL
 */
- (BOOL) getNavigationBarBackButtonDefaultStyle;

/**
 边缘返回手势
 默认: NO 关闭
 
 @return YES开启 NO关闭
 */
- (BOOL) getNavigationBarEdgePanBack;

/**
 自定义返回按钮颜色
 
 @return 颜色
 */
- (UIColor*) getNavigationBarBackButtonColor;



/**
 导航是否隐藏

 @return return value description
 */
- (BOOL) getCustomNavigationBarHidden;



/**
 使用自定义NavigationBar，子类可重写
 
 @param navigationBar 自定义NavigationBar
 */
- (void) decorateCustomNavigationBar:(NVPageNavigationBar *) navigationBar;


/**
 发丝线颜色

 @return return value description
 */
- (UIColor *) getCustomNavigationBarHairLineColor;


/**
 隐藏导航发四线

 @return return value description
 */
- (BOOL) getCustomNavigationBarHairLineHidden;



/**
 自定义右边按钮样式

 @return return value description
 */
- (NSString *) getCustomNavigationBarRightButtonTitle;
- (UIImage *) getCustomNavigationBarRightButtonImage;
- (UIColor *) getCustomNavigationBarRightButtonTintColor;
- (UIFont *) getCustomNavigationBarRightButtonFont;



/**
 自定义左边button样式

 @return return value description
 */
- (NSString *) getCustomNavigationBarLeftButtonTitle;
- (UIImage *) getCustomNavigationBarLeftButtonImage;
- (UIColor *) getCustomNavigationBarLeftButtonTintColor;
- (UIFont *) getCustomNavigationBarLeftButtonFont;


/**
 右面按钮点击事件

 @param sender sender description
 */
- (void) customNavigationBarRightButtonAction:(id)sender;


/**
 左边按钮点击事件

 @param sender sender description
 */
- (void) customNavigationBarLeftButtonAction:(id)sender;

/**
 拦截返回按钮点击事件，用于自定义事件操作处理
 
 @param sender UIBarItem
 */
- (void) backButtonAction:(id)sender;

@end
