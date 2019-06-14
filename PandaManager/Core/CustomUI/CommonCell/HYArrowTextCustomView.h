//
//  HYArrowTextCustomView.h
//  MeiFuTang
//
//  Created by lish on 2019/6/13.
//  Copyright © 2019 develop. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYArrowTextCustomView : UIView
@property (nonatomic,strong) UITextField *tf;
@property (nonatomic,copy) NSString  *name;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,copy) NSString  *icon;
- (instancetype)initWithName:(NSString *)name placeholder:(NSString *)placeholder icon:(NSString *)icon;
@end

NS_ASSUME_NONNULL_END
