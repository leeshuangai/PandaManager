//
//  HYCustomSearchBar.h
//  YQD
//
//  Created by lish on 2019/3/13.
//  Copyright © 2019 lish. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HYCustomSearchBar;
@protocol HYCustomSearchBarDelegate <NSObject>

- (void)hy_customSearchBar:(HYCustomSearchBar *)searchBar shouldReturnTextField:(UITextField *)textField;

- (void)hy_customSearchBar:(HYCustomSearchBar *)searchBar shouldClearTextField:(UITextField *)textField;

- (void)hy_customSearchBar:(HYCustomSearchBar *)searchBar willTextFieldChanged:(UITextField *)textField;

@end
@interface HYCustomSearchBar : UIView

@property (nonatomic,weak) id<HYCustomSearchBarDelegate> delegate;

- (instancetype)initWithPlaceholder:(NSString *)placeholder;

- (void)becomeFirstResponder;

- (void)textFieldResignFirstResponder;
@end

NS_ASSUME_NONNULL_END
