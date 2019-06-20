//
//  HYOrderRecordCell.h
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYOrderModel.h"
NS_ASSUME_NONNULL_BEGIN
@class HYOrderRecordCell;
@protocol HYOrderRecordCellDelegate <NSObject>

- (void)hy_orderRecordCell:(HYOrderRecordCell *)cell didCancleOrder:(HYOrderModel *)order;

@end
@interface HYOrderRecordCell : UITableViewCell

@property (nonatomic,strong) HYOrderModel *orderModel;

@property (nonatomic,weak) id<HYOrderRecordCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
