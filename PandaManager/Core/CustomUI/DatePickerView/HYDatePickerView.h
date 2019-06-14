//
//  HYDatePickerView.h
//  YQD
//
//  Created by lish on 2018/12/5.
//  Copyright © 2018 lish. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^HYDatePickerViewSelectedDateCompletion)(NSString *selectedDateFormart,NSDate *selectedDate);

@interface HYDatePickerView : UIView

@property (nonatomic,strong) UIDatePicker *datePickerView;

@property (nonatomic,strong) NSDate *selectedDate;

@property (nonatomic,strong) NSString *selectedDateFormart;

@property (nonatomic,copy) HYDatePickerViewSelectedDateCompletion selectedDateCompletion;

+ (instancetype)timeDatePickerViewWithTitle:(NSString *)title;

/**
 初始化

 @param title 标题
 @return return value description
 */
+ (instancetype)datePickerViewWithTitle:(NSString *)title;


/**
 初始化

 @param title 标题
 @param maxDate 设置最大日期
 @return return value description
 */
+ (instancetype)datePickerViewWithTitle:(NSString *)title maxDate:(NSDate *)maxDate;


/**
  初始化

 @param title 标题
 @param minDate 设置最小日期
 @return return value description
 */
+ (instancetype)datePickerViewWithTitle:(NSString *)title minDate:(NSDate *)minDate;


- (void)show;


- (void)dissmisView;

@end

NS_ASSUME_NONNULL_END
