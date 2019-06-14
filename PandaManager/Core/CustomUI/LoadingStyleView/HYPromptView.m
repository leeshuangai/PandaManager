//
//  HYPromptView.m
//  YQD
//
//  Created by lish on 2018/10/16.
//  Copyright © 2018年 lish. All rights reserved.
//

#import "HYPromptView.h"

#define kkKeyWindow [UIApplication sharedApplication].keyWindow

@interface HYPromptView()

@property (nonatomic,assign) HYPromptViewType promptViewType;

@property (nonatomic,  strong) UIView *hudView;

@property (nonatomic,  strong) UILabel *stringLabel;

@property (nonatomic,  strong) UIImageView *imageView;

@end

@implementation HYPromptView

IMP_SINGLETON;


- (void)addSubviews {
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    [self addSubview:self.hudView];
    [self.hudView addSubview:self.imageView];

    [self.hudView addSubview:self.stringLabel];
    self.tag = 100010;
    
}
//显示成功
+ (void)showSuccessHUD:(NSString *)messgae {
    
   [[HYPromptView sharedInstance] showSuccessHUD:messgae onView:nil viewType:PromptViewSuccess];
    
   
}

+ (void)showSuccessHUD:(NSString *)messgae onView:(UIView *)view{
    
    
    [[HYPromptView sharedInstance] showSuccessHUD:messgae onView:view viewType:PromptViewSuccess];
    
}


//显示error
+ (void)showErrorHUD:(NSString *)messgae {
    
   
    [[HYPromptView sharedInstance] showSuccessHUD:messgae onView:nil viewType:PromptViewError];
    
}

+ (void)showErrorHUD:(NSString *)messgae onView:(UIView *)view{
    
    
     [[HYPromptView sharedInstance] showSuccessHUD:messgae onView:view viewType:PromptViewError];
    
}


- (void)showSuccessHUD:(NSString *)message  onView:(UIView *)view viewType:(HYPromptViewType)type {
    
    if (!message.isNotBlank) {
        return;
    }
    
    //[[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    
    [self removeSubviews];
    
    [self addSubviews];
    
    if (view == nil) view = [self lastWindow];
    
    self.frame = [UIScreen mainScreen].bounds;
        
    [view addSubview:self];
    
    CGFloat iconSize = 14;
    
    CGFloat hudMargin = 20;
    
    CGFloat hudTopMargin = 14;
    
    CGFloat textMargin = 10;
    
    CGFloat textWidth = [message widthForFont: [UIFont boldSystemFontOfSize:16]];
 
    CGFloat textHeight;
    
    
    switch (type) {
        case PromptViewSuccess:
            
            if (textWidth + hudMargin*4 >= kScreenWidth ) {
                
                textWidth = kScreenWidth - hudMargin * 4;
            }
            
            textHeight = [message heightForFont:[UIFont boldSystemFontOfSize:16] width:textWidth];
            
            if (textHeight + hudTopMargin * 2 < 50) {
                
                textHeight = 50 -  hudTopMargin * 2;
                
            }
            
            _hudView .frame = CGRectMake(0, 0, textWidth+hudMargin*2, textHeight*2);
            
            _stringLabel.frame = CGRectMake(hudMargin, hudTopMargin, textWidth, textHeight);
            
            _stringLabel.centerY = _hudView.centerY;
            
            _imageView.hidden = YES;
            
            _stringLabel.textAlignment = NSTextAlignmentCenter;
            
           [self delayedDismiss];
            
            break;
            
        case PromptViewError:
            
            if (textWidth + hudMargin * 4 + iconSize + textMargin >= kScreenWidth ) {
                
                textWidth = kScreenWidth - ( hudMargin * 4 + iconSize + textMargin);
            }
            
            textHeight = [message heightForFont:[UIFont boldSystemFontOfSize:16] width:textWidth];
            
            if (textHeight + hudTopMargin * 2 < 50) {
                
                textHeight = 50 -  hudTopMargin * 2;
                
            }
            
            _hudView .frame = CGRectMake(0, 0, textWidth+hudMargin*2+textMargin+iconSize, textHeight*2);
            
             _imageView.image = [UIImage imageNamed:@"1414_HintWitlin"];
            
            
            _imageView.frame = CGRectMake(hudMargin, hudTopMargin, iconSize, iconSize);
            
            _imageView.centerY = _hudView.centerY;
            
            _stringLabel.frame = CGRectMake(_imageView.right + textMargin, hudTopMargin, textWidth, textHeight);
            
            _stringLabel.centerY = _hudView.centerY;
            
            
            _stringLabel.textAlignment = NSTextAlignmentCenter;
            
            [self delayedDismiss];
            
            break;

    }
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    
    self.hudView.center = self.center;
    
    self.stringLabel.text = message;
    
  
}


+ (void)hiddenLoadingHUD {
    
    [[HYPromptView sharedInstance]removeSubviews];
    
}

- (void)delayedDismiss {
    
    [UIView animateWithDuration:1.0 animations:^{
        [self->_hudView setAlpha:1];
    } completion:^(BOOL finished) {
        [self close];
    }];
    
}

- (void)close
{
    [UIView animateWithDuration:0.5 delay:1.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self->_hudView setAlpha:0];
                     }
                     completion:^(BOOL finished) {
                        
                         [self removeSubviews];
                        
                     } ];
    
}

- (void)removeSubviews {
    
    [self.stringLabel removeFromSuperview];
    [self.imageView removeFromSuperview];
    [self.hudView removeFromSuperview];
    [self removeFromSuperview];
 
 
}


- (UIWindow *)lastWindow
{
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
//        _imageView.image = [UIImage imageNamed:@"1414_HintWitlin"];
    }
    return _imageView;
}

@end
