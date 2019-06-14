//
//  HYAvaterCustomCell.h
//  MeiFuTang
//
//  Created by lish on 2019/6/13.
//  Copyright © 2019 develop. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HYAvaterCustomCellwHandle)(void);
NS_ASSUME_NONNULL_BEGIN

@interface HYAvaterCustomCell : UITableViewCell

@property (nonatomic,strong) NSData *avaterData;
@property (nonatomic,copy) HYAvaterCustomCellwHandle selectedHandle;
@end

NS_ASSUME_NONNULL_END
