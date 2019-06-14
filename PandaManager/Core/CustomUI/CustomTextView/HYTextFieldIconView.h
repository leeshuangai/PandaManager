//
//  HYTextFieldIconView.h
//  YQD
//
//  Created by lish on 2018/10/23.
//  Copyright © 2018年 lish. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYTextFieldIconView;

NS_ASSUME_NONNULL_BEGIN
@protocol HYTextFieldIconViewDelegate <NSObject>

@optional;

- (void)hy_textFieldView:(HYTextFieldIconView *)textFieldView textChanged:(UITextField *)textField;

@end


@interface HYTextFieldIconView : UIView


@property (nonatomic,weak) id<HYTextFieldIconViewDelegate> delegate;

@property (nonatomic,assign) BOOL isSecure;

@property (nonatomic,strong) UITextField *textField;


- (instancetype)initWithPlaceholder:(NSString *)placeholder icon:(NSString *)icon;


@end

NS_ASSUME_NONNULL_END
