//
//  HYAPIManager+Features.h
//  TeamDevelop
//
//  Created by lish on 2019/6/14.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYAPIManager.h"
#import "HYClassroomModel.h"
#import "HYOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYAPIManager (Features)
- (void)querySubcribeClassroomRecordWithDate:(NSDate *)date classroomName:(NSString *)classroomName Completion:(void(^)(BOOL success,id data,NSString *error))completion ;

- (void)queryCancleSubcribeClassroomWithModel:(HYOrderModel *)model classroomName:(NSString *)classroomName Completion:(void(^)(BOOL success,id data,NSString *error))completion;

- (void)querySaveSubcribeClassroomRecord;
    
- (void)queryDefaultClassroomList;

//添加j教学楼
- (void)queryAddClassromWithClassModel:(HYClassroomModel *)model  completion:(void(^)(BOOL success,id data,NSString *error))completion;

//获取教学楼
- (void)queryObtainClassromListWithCompletion:(void(^)(BOOL success,id data,NSString *error))completion;

- (void)queryModifyClassrommWithModel:(HYClassroomModel *)model completion:(void(^)(BOOL success,id data,NSString *error))completion;


- (void)queryDeleteClassromWithClassModel:(HYClassroomModel *)model  completion:(void(^)(BOOL success,id data,NSString *error))completion;
@end

NS_ASSUME_NONNULL_END
