//
//  HYArrowCustomView.h
//  MeiFuTang
//
//  Created by lish on 2019/6/13.
//  Copyright © 2019 develop. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^HYArrowCustomViewHandle)(void);
typedef void(^HYTapArrowCustomViewHandle)(NSString *name);
@interface HYArrowCustomView : UIView

@property (nonatomic,copy) NSString  *name;

@property (nonatomic,copy) NSString  *detail;

@property (nonatomic,copy) NSString  *icon;

@property (nonatomic,copy) HYTapArrowCustomViewHandle tapArrowNameHandle;
@property (nonatomic,copy) HYArrowCustomViewHandle tapArrowHandle;

- (instancetype)initWithName:(NSString *)name detail:(NSString *)detail icon:(NSString *)icon;
@end

NS_ASSUME_NONNULL_END
