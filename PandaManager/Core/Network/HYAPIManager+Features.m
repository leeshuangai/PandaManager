//
//  HYAPIManager+Features.m
//  TeamDevelop
//
//  Created by lish on 2019/6/14.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYAPIManager+Features.h"

#import "NSFileManager+Category.h"

#import "TPFileHelper.h"
@implementation HYAPIManager (Features)

- (void)querySaveSubcribeClassroomRecord {
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"firstSave"]isEqualToString:@"01"]) {
        
        return;
    }

    HYOrderModel *model = [[HYOrderModel alloc]init];
    model.orderId =[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:ss:mm"];
    model.orderStatus = @"预约成功";
    model.orderClassroom = @"博学楼";
    model.classFloor = @"201";
    model.orderDate = [[[NSDate date] dateByAddingDays:2] stringWithFormat:@"yyyy-MM-dd"];
    
    model.orderTime = @"08:00-10:00";
    model.className = @"2017届翻译1班基础课";
    
    model.orderUserName = @"曾老师";
    model.orderIdentityNumber = @"身份证号码：510131197012042345";
    model.orderNameDepartment = @"院系：医学院";
    model.orderOffice = @"办公室：励志楼203号";
    model.orderMobile = @"电话：19945326754";
    model.orderAvaterData = UIImageJPEGRepresentation([UIImage imageNamed:@"resource_ellipse"], 0.8);
    
    
  [NSFileManager saveModelObject:@[model] fileName:[self classroomRecordFileName]];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"01" forKey:@"firstSave"];
}


- (void)queryCancleSubcribeClassroomWithModel:(HYOrderModel *)model classroomName:(NSString *)classroomName Completion:(void(^)(BOOL success,id data,NSString *error))completion
{
    
    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        if (success) {
            
            NSMutableArray *list = [NSMutableArray arrayWithArray:[NSFileManager getModelObjectByFileName:[self classroomRecordFileName]]];
            
            [list enumerateObjectsUsingBlock:^(HYOrderModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.orderId isEqualToString:model.orderId]) {
                    
                    obj.orderStatus = @"已取消";
                }
                
                
            }];
            
            
            
            [NSFileManager saveModelObject:list fileName:[self classroomRecordFileName]];
            
            if (completion) {
                completion(success,list,error);
            }
            
        }else {
            if (completion) {
                completion(success,data,error);
            }
        }
        
    }];
}

- (void)querySubcribeClassroomRecordWithDate:(NSDate *)date classroomName:(NSString *)classroomName Completion:(void(^)(BOOL success,id data,NSString *error))completion  {
    

    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        if (![[HYUserManager shareInstance].currentUser.userId isEqualToString:@"18833206604"]) {
            if (completion) {
                completion(YES,@[],nil);
            }
            return ;
        }
        if (success) {
            
            NSMutableArray *list = [NSMutableArray arrayWithArray:[NSFileManager getModelObjectByFileName:[self classroomRecordFileName]]];
            
            NSMutableArray *lists = [NSMutableArray array];
            
            [list enumerateObjectsUsingBlock:^(HYOrderModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                if ([obj.orderClassroom isEqualToString:classroomName] &&[obj.orderDate isEqualToString:[NSString stringFromDate:date]] ) {
                    
                   [lists addObject:obj];
                }
                
                
            }];
            
            
            if (completion) {
                completion(success,lists,error);
            }
            
        }else {
            if (completion) {
                completion(success,data,error);
            }
        }
        
    }];
    
}

- (void)queryDefaultClassroomList {
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"first"]isEqualToString:@"01"]) {
      
        return;
    }
     NSArray *list =  [NSArray yy_modelArrayWithClass:[HYClassroomModel class] json:[TPFileHelper loadingMainBundleJsonResouJsonResourceWithFileName:@"ClassroomInfo"]];
    
     [NSFileManager saveModelObject:list fileName:[self classroomListFileName]];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"01" forKey:@"first"];
  
}

//添加j教学楼
- (void)queryAddClassromWithClassModel:(HYClassroomModel *)model  completion:(void(^)(BOOL success,id data,NSString *error))completion {
    
    
    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
       
        if (success) {
            
            NSMutableArray *list = [NSMutableArray arrayWithArray:[NSFileManager getModelObjectByFileName:[self classroomListFileName]]];
           
            NSMutableArray *nums= [NSMutableArray array];
           
            for (int i = 0; i<model.flooorCount.intValue; i++) {
                [nums  addObject:model.classroomCount];
                
            }
            
            model.floorInfo = nums.mutableCopy;
            
       
            NSDate *date = [NSDate date];

            model.classroomId  = [date stringWithFormat:@"yyyy-MM-dd HH:ss:mm"];
            
            [list addObject:model];
            
            [NSFileManager saveModelObject:list fileName:[self classroomListFileName]];
            
            if (completion) {
                completion(success,list,error);
            }
            
        }else {
            if (completion) {
                completion(success,data,error);
            }
        }
        
    }];
    
    
}

- (void)queryDeleteClassromWithClassModel:(HYClassroomModel *)model  completion:(void(^)(BOOL success,id data,NSString *error))completion {
    
    
    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        if (success) {
            
            NSMutableArray *list = [NSMutableArray arrayWithArray:[NSFileManager getModelObjectByFileName:[self classroomListFileName]]];
            
            [list enumerateObjectsUsingBlock:^(HYClassroomModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.classroomId isEqualToString:model.classroomId]) {
                    
                    [list  removeObject:obj];
                    
                }
            }];
            
            [NSFileManager saveModelObject:list fileName:[self classroomListFileName]];
            
            if (completion) {
                completion(success,list,error);
            }
            
        }else {
            if (completion) {
                completion(success,data,error);
            }
        }
        
    }];
    
    
}


- (void)queryModifyClassrommWithModel:(HYClassroomModel *)model completion:(void(^)(BOOL success,id data,NSString *error))completion {
    
    
    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        if (success) {
            
            NSMutableArray *list = [NSMutableArray arrayWithArray:[NSFileManager getModelObjectByFileName:[self classroomListFileName]]];
            
            [list enumerateObjectsUsingBlock:^(HYClassroomModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.classroomId isEqualToString:model.classroomId]) {
                    
                    [list replaceObjectAtIndex:idx withObject:model];
                    
                }
            }];
            
            [NSFileManager saveModelObject:list fileName:[self classroomListFileName]];
            
            if (completion) {
                completion(success,model,error);
            }
            
        }else {
            if (completion) {
                completion(success,data,error);
            }
        }
        
    }];
    
}

//获取教学楼
- (void)queryObtainClassromListWithCompletion:(void(^)(BOOL success,id data,NSString *error))completion {
    
    
    [self postNoHudWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        if (success) {
            
            NSArray *list = [NSArray arrayWithArray:[NSFileManager getModelObjectByFileName:[self classroomListFileName]]];
            
            if (completion) {
                completion(success,list,error);
            }
            
        }else {
            if (completion) {
                completion(success,data,error);
            }
        }
        
    }];
    
    
}

- (void)queryCancleOrderWithOrderId:(NSString *)orderId completion:(void(^)(BOOL success,id data,NSString *error))completion {
    [self postWithCompletion:^(BOOL success, id  _Nonnull data, NSString * _Nonnull error) {
        
        
        if (success) {
            
            NSMutableArray *list = [NSMutableArray arrayWithArray:[NSFileManager getModelObjectByFileName:[self orderRecordFileName]]];
            
            [list enumerateObjectsUsingBlock:^(HYOrderModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj.orderId isEqualToString:orderId]) {
                    obj.orderStatus = @"已取消";
                }
                
            }];
            
            
            [NSFileManager saveModelObject:list fileName:[self orderRecordFileName]];
            
            if (completion) {
                completion(success,list,error);
            }
            
        }else{
            
            if (completion) {
                completion(success,data,error);
            }
        }
        
    }];
    
    
}




#pragma mark private method
- (NSString *)orderRecordFileName {
    
    return [NSString stringWithFormat:@"%@",@"userOrderRecord"];
    
}

- (NSString *)classroomListFileName {
    
    return [NSString stringWithFormat:@"%@",@"userclassroomList"];
    
}

- (NSString *)classroomRecordFileName {
    
    return [NSString stringWithFormat:@"%@",@"userclassroomRecord"];
    
}


@end
