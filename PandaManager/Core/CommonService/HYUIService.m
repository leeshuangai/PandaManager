//
//  HYUIService.m
//  TeamDevelop
//
//  Created by lish on 2019/6/14.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYUIService.h"

@implementation HYUIService

+ (UILabel *)initUILabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {
    
    UILabel * label = [[UILabel alloc]init];
    
    if (textColor) label.textColor = textColor;
    if (font)label.font = font;
    if (text.isNotBlank) label.text = text;
    return label;
}

+ (UIButton *)initUIButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (titleColor)  [btn setTitleColor:titleColor forState:0];
    if (font)btn.titleLabel.font = font;
    if (title.isNotBlank)  [btn setTitle:title forState:0];
    return btn;
}

+ (UITableView *)initUITableViewWithFrame:(CGRect )frame style:(UITableViewStyle)style backgroundColor:(UIColor *)backgroundColor {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:style];
    tableView.backgroundColor = backgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.estimatedRowHeight = 44;
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    return tableView;
}



@end
