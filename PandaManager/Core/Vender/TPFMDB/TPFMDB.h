//
//  JQFMDB.h
//
//  Created by Joker on 17/3/7.
//  GitHub: https://github.com/gaojunquan/JQFMDB
//

#import <Foundation/Foundation.h>

@interface TPFMDB : NSObject
/**
 单例方法创建数据库
 默认在NSDocumentDirectory下创建
 dbName
 */
+ (instancetype)shareDatabase;


/**
 创建表 通过传入的model或dictionary(如果是字典注意类型要写对),虽然都可以不过还是推荐以下都用model

 @param tableName 表的名称
 @param parameters 设置表的字段,可以传model(runtime自动生成字段)或字典(格式:@{@"name":@"TEXT"})
 @return 是否创建成功
 */
- (BOOL)createTable:(NSString *)tableName dicOrModel:(id)parameters;

/**
 同上,
 @param nameArr 不允许model或dic里的属性/key生成表的字段,如:nameArr = @[@"name"],则不允许名为name的属性/key 生成表的字段
 
 */
- (BOOL)createTable:(NSString *)tableName dicOrModel:(id)parameters excludeName:(NSArray *)nameArr;

/**
 增加: 向表中插入数据

 @param tableName 表的名称
 @param parameters 要插入的数据,可以是model或dictionary(格式:@{@"name":@"小李"})
 @return 是否插入成功
 */
- (BOOL)insertTable:(NSString *)tableName dicOrModel:(id)parameters;

/**
 批量增加:
 
 @param dicOrModelArray 要insert/update数据的数组,也可以将model和dictionary混合装入array
 @return 返回的数组存储未插入成功的下标,数组中元素类型为NSNumber
 */
- (NSArray *)insertTable:(NSString *)tableName dicOrModelArray:(NSArray *)dicOrModelArray;



/**
 删除: 根据条件删除表中数据

 @param tableName 表的名称
 @param format 条件语句, 如:@"where name = '小李'"
 @return 是否删除成功
 */

- (BOOL)deleteTable:(NSString *)tableName whereFormat:(NSString *)format, ...;

/**
 删除表
 
 @param tableName tableName description
 @return return value description
 */
- (BOOL)deleteTable:(NSString *)tableName;


/**
 清空表
 
 @param tableName tableName description
 @return return value description
 */
- (BOOL)deleteAllDataFromTable:(NSString *)tableName;


/**
 更改: 根据条件更改表中数据

 @param tableName 表的名称
 @param parameters 要更改的数据,可以是model或dictionary(格式:@{@"name":@"张三"})
 @param format 条件语句, 如:@"where name = '小李'"
 @return 是否更改成功
 */
- (BOOL)updateTable:(NSString *)tableName dicOrModel:(id)parameters whereFormat:(NSString *)format, ...;

/**
 查找: 根据条件查找表中数据

 @param tableName 表的名称
 @param parameters 每条查找结果放入model(可以是[Person class] or @"Person" or Person实例)或dictionary中
 @param format 条件语句, 如:@"where name = '小李'",
 @return 将结果存入array,数组中的元素的类型为parameters的类型
 */
- (NSArray *)lookupTable:(NSString *)tableName dicOrModel:(id)parameters whereFormat:(NSString *)format, ...;


/**
 查找表中所有数据

 @param tableName tableName description
 @param parameters parameters description
 @return return value description
 */
- (NSArray *)lookupAllData:(NSString *)tableName dicOrModel:(id)parameters;


/**
 分页查询 当arr为0时说明已经查完所有数据
 
 @param tableName  表名
 @param range      位置
 @param count      条数
 @param parameters parameters description
 @return 数组
 */
- (NSArray *)lookupDataWithTableName:(NSString *)tableName dicOrModel:(id)parameters range:(NSInteger)range count:(NSInteger)count;



/**
 是否存在表

 @param tableName tableName description
 @return return value description
 */
- (BOOL)isExistTable:(NSString *)tableName;



/**
 表中共有多少条数据

 @param tableName tableName description
 @return return value description
 */
- (int)tableItemCount:(NSString *)tableName;


/**
 返回表中的字段名

 @param tableName tableName description
 @return return value description
 */
- (NSArray *)columnNameArray:(NSString *)tableName;







// =============================   线程安全操作    ===============================

/**
 将操作语句放入block中即可保证线程安全, 如:
 
 Person *p = [[Person alloc] init];
 p.name = @"小李";
 [jqdb jq_inDatabase:^{
 [jqdb jq_insertTable:@"users" dicOrModel:p];
 }];
 */
- (void)inDatabase:(void (^)(void))block;


/**
 事务: 将操作语句放入block中可执行回滚操作(*rollback = YES;)
 
 Person *p = [[Person alloc] init];
 p.name = @"小李";
 
 for (int i=0,i < 1000,i++) {
 [jq jq_inTransaction:^(BOOL *rollback) {
 BOOL flag = [jq jq_insertTable:@"users" dicOrModel:p];
 if (!flag) {
 *rollback = YES; //只要有一次不成功,则进行回滚操作
 return;
 }
 }];
 }

 */
- (void)inTransaction:(void(^)(BOOL *rollback))block;


@end


