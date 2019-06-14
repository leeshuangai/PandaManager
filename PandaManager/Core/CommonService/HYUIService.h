//
//  HYUIService.h
//  TeamDevelop
//
//  Created by lish on 2019/6/14.
//  Copyright © 2019 develop. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUIService : NSObject
+ (UILabel *)initUILabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;


+ (UIButton *)initUIButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;


+ (UITableView *)initUITableViewWithFrame:(CGRect )frame style:(UITableViewStyle)style backgroundColor:(UIColor *)backgroundColor;
@end

NS_ASSUME_NONNULL_END
