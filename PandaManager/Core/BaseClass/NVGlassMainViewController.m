//
//  NVGlassMainViewController.m
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVGlassMainViewController.h"
#import "UIImage+Convert.h"
#import "UIColor+Convert.h"
#import "NSString+JKSize.h"
#import "UIView+JKCustomBorder.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@implementation NVPageNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        kSTATUSBARHEIGHT,
                                                                        self.width*0.7,
                                                                        44.0f)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.centerX = self.width/2.0f;
        titleLabel.font = kBoldSystemFontSize(17);
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        self.titleLabel.centerX = self.width/2.0f;
    }
    return self;
}

- (void)setLeftButton:(UIButton *)leftButton {
    if (_leftButton != leftButton) {
        [_leftButton removeFromSuperview];
        
        _leftButton = leftButton;
        [self addSubview:_leftButton];
        
        //动态设置宽度
        CGFloat textWidth = [_leftButton.titleLabel.text jk_widthWithFont:_leftButton.titleLabel.font constrainedToHeight:_leftButton.height];
        CGFloat width = 0.0f;
        if (_leftButton.currentImage != nil) {
            UIImage *image = _leftButton.currentImage;
            CGFloat heightInPoints = image.size.height;
            CGFloat heightInPixels = heightInPoints * image.scale;
            CGFloat widthInPoints = image.size.width;
            CGFloat widthInPixels = widthInPoints * image.scale;
            
            CGFloat imageWidth = widthInPoints;
            width += imageWidth;
        }
        
        if (leftButton.titleLabel.text.length > 0) {
            width += textWidth;
        }
        
        if (leftButton.titleLabel.text.length > 0 && _leftButton.currentImage != nil) {
            width += NVNavigationBarButtonImageTextSpace;
        }
        
        width = width < 30?30:width;
        
        _leftButton.width = width;
        
        _leftButton.centerY = (self.height-kSTATUSBARHEIGHT)/2+kSTATUSBARHEIGHT;
        _leftButton.left = NVNavigationBarButtonDistanceToEdge;
        
    }
}

- (void)setRightButton:(UIButton *)rightButton {
    if (_rightButton != rightButton) {
        [_rightButton removeFromSuperview];
        
        _rightButton = rightButton;
        [self addSubview:_rightButton];
        
        //动态设置宽度
        CGFloat textWidth = [_rightButton.titleLabel.text jk_widthWithFont:_rightButton.titleLabel.font constrainedToHeight:_rightButton.height];
        CGFloat width = 0.0f;
        if (_rightButton.currentImage != nil) {
            UIImage *image = _rightButton.currentImage;
            CGFloat heightInPoints = image.size.height;
            CGFloat heightInPixels = heightInPoints * image.scale;
            CGFloat widthInPoints = image.size.width;
            CGFloat widthInPixels = widthInPoints * image.scale;
            
            CGFloat imageWidth = widthInPoints;
            width += imageWidth;
        }
        
        if (rightButton.titleLabel.text.length > 0) {
            width += textWidth;
        }
        
        if (rightButton.titleLabel.text.length > 0 && _rightButton.currentImage != nil) {
            width += NVNavigationBarButtonImageTextSpace;
        }
        
        width = width < 30?30:width;
        
        _rightButton.width = width;
        
        _rightButton.centerY = (self.height-kSTATUSBARHEIGHT)/2+kSTATUSBARHEIGHT;
        _rightButton.right = self.width - NVNavigationBarButtonDistanceToEdge;
    }
}

@end

@interface NVGlassMainViewController ()

@end

@implementation NVGlassMainViewController

#pragma mark - LifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    //隐藏自定义导航
    self.pageNavigationBar.hidden = [self getCustomNavigationBarHidden];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
      [self decorateCustomNavigationBar:self.pageNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = [self getPopGestureRecognizer];
}

#pragma mark - CustomNavigationBar
- (void) decorateCustomNavigationBar:(NVPageNavigationBar *) navigationBar {
    
    self.navigationController.navigationBar.hidden = YES;
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    
    if ([self getStatusBarIsLight]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    navigationBar.backgroundColor = [self getNavigationBarBackgroundColor];
    navigationBar.titleLabel.text = [self getNavigationTitle];
    navigationBar.titleLabel.textColor = [self getNavigationTitleColor];
    
    //左边按钮
    BOOL flag = NO;
    if ([self getCustomNavigationBarLeftButtonImage]!=nil ||
        [self getCustomNavigationBarLeftButtonTitle].length > 0) {
        flag = YES;
        navigationBar.leftButton = [self newLeftButton];
    }
    
    //返回按钮
    if (!flag) {
        if ([self.navigationController.viewControllers count] > 1) {
            UIButton* backBtn = [self newBackButton];
            navigationBar.leftButton = backBtn;
        }
    }
    
    //右边按钮
    if ([self getCustomNavigationBarRightButtonImage] != nil
        || [self getCustomNavigationBarRightButtonTitle].length > 0) {
        UIButton* backBtn = [self newRightButton];
        navigationBar.rightButton = backBtn;
    }
    
    //发丝线
    if (!self.getCustomNavigationBarHairLineHidden) {
        [self.pageNavigationBar jk_addBottomBorderWithColor:self.getCustomNavigationBarHairLineColor width:0.5];
    } else {
        [self.pageNavigationBar jk_removeBottomBorder];
    }
    
   
}
#pragma mark - Events
- (void) backButtonAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) customNavigationBarRightButtonAction:(id)sender {
    
}

- (void) customNavigationBarLeftButtonAction:(id)sender {
    
}

#pragma mark - NavigationTitle
- (BOOL) getCustomNavigationBar {
    return YES;
}

- (BOOL) getStatusBarIsLight {
    return NO;
}

- (NSString*) getNavigationTitle {
    return self.title;
}

- (UIColor*) getNavigationTitleColor {
    return [UIColor blackColor];
}


- (BOOL) getNavigationBarBackButtonDefaultStyle {
    return NO;
}

- (BOOL) getPopGestureRecognizer {
    return YES;
}

- (UIColor*) getNavigationBarBackButtonColor {
    return NVNavigationBarButtonDefaultTintColor;
}

- (UIColor*) getNavigationBarBackgroundColor {
    
    return COLOR_JJ_DEFAULT_WHITE;
}

- (NSString *) getCustomNavigationBarRightButtonTitle {
    return @"";
}

- (UIImage *) getCustomNavigationBarRightButtonImage {
    return nil;
}

- (UIColor *) getCustomNavigationBarRightButtonTintColor {
    return NVNavigationBarButtonDefaultTintColor;
}

- (UIFont *) getCustomNavigationBarRightButtonFont {
    return kSystemFontSize(17);
}

- (NSString *) getCustomNavigationBarLeftButtonTitle {
    return @"";
}

- (UIImage *) getCustomNavigationBarLeftButtonImage {
    return nil;
}

- (UIColor *) getCustomNavigationBarLeftButtonTintColor {
    return NVNavigationBarButtonDefaultTintColor;
}

- (UIFont *) getCustomNavigationBarLeftButtonFont {
    return kSystemFontSize(17);
}

- (UIColor *) getCustomNavigationBarHairLineColor {
    return COLOR_JJ_LINE;
}

- (BOOL) getCustomNavigationBarHairLineHidden {
    return YES;
}
- (BOOL) getCustomNavigationBarHidden {
    return NO;
}
#pragma mark - Private

- (NVPageNavigationBar *)pageNavigationBar {
    if (_pageNavigationBar == nil) {
        CGFloat height = 44+kSTATUSBARHEIGHT;
        CGRect frame = CGRectMake(0, 0, kScreenWidth, height);
        _pageNavigationBar = [[NVPageNavigationBar alloc] initWithFrame:frame];
        [self.view addSubview:_pageNavigationBar];
    }
    
    return _pageNavigationBar;
}
- (UIButton *) newBackButton {
    
    UIImage *btnImage = [[UIImage imageNamed:NVNavigationBackImage] imageWithColor:[self getNavigationBarBackButtonColor]];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, 30.0f, 40.0f);
    
    [btn.titleLabel setFont:[self getCustomNavigationBarLeftButtonFont]];
    [btn setTitle:@"    " forState:UIControlStateNormal];
    [btn setTitleColor:NVNavigationBarButtonDefaultTintColor forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    [btn setImage:btnImage forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    [btn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIButton *) newRightButton {
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, 100.0f, 40.0f);
    
    [btn.titleLabel setFont:[self getCustomNavigationBarRightButtonFont]];
    [btn setTitleColor:[self getCustomNavigationBarRightButtonTintColor] forState:UIControlStateNormal];
   
    [btn setTitleColor:[UIColor colorRGBConvertToHSB:[self getCustomNavigationBarRightButtonTintColor] withAlphaDelta:NVNavigationBarTintColorDelta] forState:UIControlStateHighlighted];
    [btn setTitle:[self getCustomNavigationBarRightButtonTitle] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    UIImage *image = [self getCustomNavigationBarRightButtonImage];
    if (image != nil) {
        if ([self getCustomNavigationBarRightButtonTitle].length > 0) {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, NVNavigationBarButtonImageTextSpace);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, NVNavigationBarButtonImageTextSpace, 0, 0);
        }
        
        UIImage *btnImage = [image imageWithColor:[self getCustomNavigationBarRightButtonTintColor]];
        UIImage *btnSelectedImage = [image imageWithColor:[UIColor colorRGBConvertToHSB:[self getCustomNavigationBarRightButtonTintColor] withAlphaDelta:NVNavigationBarTintColorDelta]];
        [btn setImage:btnImage forState:UIControlStateNormal];
        [btn setImage:btnSelectedImage forState:UIControlStateHighlighted];
    }
    
    [btn addTarget:self action:@selector(customNavigationBarRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIButton *) newLeftButton {
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, 100.0f, 40.0f);
    
    [btn.titleLabel setFont:[self getCustomNavigationBarLeftButtonFont]];
    [btn setTitleColor:[self getCustomNavigationBarLeftButtonTintColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorRGBConvertToHSB:[self getCustomNavigationBarLeftButtonTintColor] withAlphaDelta:NVNavigationBarTintColorDelta] forState:UIControlStateHighlighted];
    [btn setTitle:[self getCustomNavigationBarLeftButtonTitle] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    UIImage *image = [self getCustomNavigationBarLeftButtonImage];
    if (image != nil) {
        if ([self getCustomNavigationBarLeftButtonTitle].length > 0) {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, NVNavigationBarButtonImageTextSpace);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, NVNavigationBarButtonImageTextSpace, 0, 0);
        }
        
        UIImage *btnImage = [image imageWithColor:[self getCustomNavigationBarLeftButtonTintColor]];
        UIImage *btnSelectedImage = [image imageWithColor:[UIColor colorRGBConvertToHSB:[self getCustomNavigationBarLeftButtonTintColor] withAlphaDelta:NVNavigationBarTintColorDelta]];
        [btn setImage:btnImage forState:UIControlStateNormal];
        [btn setImage:btnSelectedImage forState:UIControlStateHighlighted];
    }
    
    [btn addTarget:self action:@selector(customNavigationBarLeftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}




@end
