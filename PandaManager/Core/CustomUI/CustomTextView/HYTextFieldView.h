//
//  HYTextFieldView.h
//  YQD
//
//  Created by lish on 2018/10/23.
//  Copyright © 2018年 lish. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYTextFieldView;


NS_ASSUME_NONNULL_BEGIN
@protocol HYTextFieldViewDelegate <NSObject>

@optional;
- (void)hy_textFieldView:(HYTextFieldView *)textFieldView textChanged:(UITextField *)textField;


@end


@interface HYTextFieldView : UIView



@property (nonatomic,weak) id<HYTextFieldViewDelegate> delegate;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *placeholder;

@property (nonatomic,strong) UITextField *textField;



- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
