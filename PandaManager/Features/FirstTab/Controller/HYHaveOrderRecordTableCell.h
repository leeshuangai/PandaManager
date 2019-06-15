//
//  HYHaveOrderRecordTableCell.h
//  Panda
//
//  Created by lish on 2019/5/31.
//  Copyright © 2019 panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYOrderModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface HYOrderRecordView : UIView

@property (nonatomic,strong) HYOrderModel *orderModel;

@end
@interface HYHaveOrderRecordTableCell : UITableViewCell

@property (nonatomic,strong) NSArray <HYOrderModel *>*orderModels;


@end

NS_ASSUME_NONNULL_END
