//
//  AppConfiguration.h
//  TeamDevelop
//
//  Created by lish on 2019/6/5.
//  Copyright © 2019 develop. All rights reserved.
//app 配置

#ifndef AppConfiguration_h
#define AppConfiguration_h

//Tab设置
// 字体未选中颜色设置
#define TAB_TITLE_NORMAL_COLOR      COLOR_JJ_TEXT_MAIN
// 字体选中颜色设置
#define TAB_TITLE_SELECTED_COLOR    COLOR_JJ_THEME
// 字体的大小样式设置
#define TAB_TITLE_FONT             [UIFont systemFontOfSize:10]
// Tab 背景颜色
#define TAB_BACK_CORLOR            COLOR_JJ_DEFAULT_WHITE
// Tabh根控制器
#define TAB_CONTROLLER_NAMES @[@"HYFirstTabViewController",@"HYPodfileViewController"]
//Tab图标集合
#define TABBAR_ICONS @[@"tabbar_home",@"tabbar_podfile"]
//Tabbar t标题
#define TABBAR_TITLES @[@"首页",@"我的"]

// Nav 设置
// Nav返回箭头图片
#define NAV_BACK_NAME               @"icon_back"

#define NAV_BACK_SELECTED_NAME      @"icon_back"

#define NAV_TITLE_COLOR             COLOR_JJ_DEFAULT_WHITE

#define NAV_BACKGROUND_COLOR        COLOR_JJ_BLUE_THEME

#define NAV_LEFT_TINT_COLOR          COLOR_JJ_DEFAULT_WHITE

#define NAV_RIGHT_TINT_COLOR         COLOR_JJ_DEFAULT_WHITE

#define NAV_BACK_COLOR               COLOR_JJ_DEFAULT_WHITE

#define STATUS_BAR_LIGHT     YES


#endif /* AppConfiguration_h */
