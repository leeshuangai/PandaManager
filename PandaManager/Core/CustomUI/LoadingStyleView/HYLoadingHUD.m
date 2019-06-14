//
//  HYLoadingHUD.m
//  YQD
//
//  Created by lish on 2018/10/19.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "HYLoadingHUD.h"



@interface HYLoadingHUD()

@property (nonatomic,  strong) UIView *hudView;

@property (nonatomic,  strong) UILabel *stringLabel;

@property (nonatomic,  strong) UIImageView *imageView;

@end

@implementation HYLoadingHUD

IMP_SINGLETON;


- (void)addSubviews {
    
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    [self addSubview:self.hudView];
    [self.hudView addSubview:self.imageView];
    
    [self.hudView addSubview:self.stringLabel];
    self.tag = 100010;
    
}

//加载框
+ (void)showLoadingHUD {
    
    [[HYLoadingHUD sharedInstance] showSuccessHUD:@"加载中" onView:nil ];
}

+ (void)showLoadingHUD:(NSString *)messgae {
    
    
    [[HYLoadingHUD sharedInstance] showSuccessHUD:messgae onView:nil ];
}

+ (void)showLoadingHUD:(NSString *)messgae onView:(UIView *)view {
    
    [[HYLoadingHUD sharedInstance]showSuccessHUD:messgae onView:view ];
}

- (void)showSuccessHUD:(NSString *)message  onView:(UIView *)view  {
    
    
    [self removeSubviews];
    
    [self addSubviews];
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    view.hidden = NO;
    
    self.frame = [UIScreen mainScreen].bounds;
    
    [view addSubview:self];
    
            
            self.hudView.backgroundColor = HEX(0x000000);
            
            self.hudView .frame = CGRectMake(0, 0, 100,100);
            
            self.hudView.center = self.center;
            
            self.imageView.image = [UIImage imageNamed:@"3030_LodWitlin"];
    
   
    
            [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.centerX.equalTo(self.hudView);
                make.top.equalTo(self.hudView.mas_top).offset(25);
            }];

            [self.stringLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.equalTo(self.hudView.mas_bottom).offset(-15);
                make.centerX.equalTo(self.hudView);
            }];
            
            _stringLabel.textAlignment = NSTextAlignmentCenter;
            
            
            [self loadAnimation];
            
      
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.hudView.center = self.center;
    
    self.stringLabel.text = message;
    
    
}

- (void)loadAnimation {
    
    
    CABasicAnimation* rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

+ (void)hiddenLoadingHUD {
    
    [[HYLoadingHUD sharedInstance]removeSubviews];
    
}



- (void)removeSubviews {
    
    [self.stringLabel removeFromSuperview];
    [self.imageView removeFromSuperview];
    [self.hudView removeFromSuperview];
  
    [self removeFromSuperview];
  
}


- (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}


- (UIView *)hudView {
    
    if (!_hudView) {
        _hudView = [[UIView alloc]init];
        
        _hudView.backgroundColor = HEX(0x000000);
        
        _hudView.layer.cornerRadius = 5;
    }
    return _hudView;
    
}

- (UILabel *)stringLabel {
    
    if (!_stringLabel) {
        _stringLabel = [[UILabel alloc]init];
        _stringLabel.textColor = [UIColor whiteColor];
        _stringLabel.numberOfLines = 0;
        _stringLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _stringLabel;
    
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}


@end
