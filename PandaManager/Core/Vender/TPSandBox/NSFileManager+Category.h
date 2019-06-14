//
//  NSFileManager+Category.h
//  TJFileManager
//
//  Created by lish on 2017/8/1.
//  Copyright © 2017年 lish. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^NSFileManagerObtainCompleteBlock) (BOOL succeed,id result);
@interface NSFileManager (Category)
#pragma mark - 获取沙盒目录相关

/**
 获取沙盒根目录
 
 @return 返回路径
 */
+ (NSString *)sanBoxHomeDirectory;

/**
 获取documents路径
 
 @return 返回路径
 */
+ (NSString *)sanBoxDocumentsDirectory;


/**
 获取documents目录下指定文件名的全路径
 
 @param fileName 文件名字
 @return 返回路径
 */
+ (NSString *)sanBoxFilePathWithFileName:(NSString *)fileName;


/**
 获取tmp路径
 
 @return 返回路径
 */
+ (NSString *)sanBoxTmpDirectory;

/**
 获取cache路径
 
 @return 返回路径
 */
+ (NSString *)sanBoxCacheDirectory;

/**
 获取library路径
 
 @return 返回路径
 */
+ (NSString *)sanBoxLibraryDirectory;

#pragma mark - 文件操作相关

/**
 *  沙盒documents目录下创建新的文件夹
 *
 *  @param directoryName 文件夹名字
 *
 *  @return 是否创建文件夹成功
 */
+ (BOOL)createNewDirectoryWithName:(NSString *)directoryName;

/**
 *  判断文件是否存在
 *
 *  @param filePath 文件路径
 *
 *  @return 是否存在
 */
+ (BOOL)fileExistWithPath:(NSString *)filePath;

/**
 *  获取文件的大小(单位字节，转换成kb需要除以1024)
 *
 *  @param path 文件路径
 *
 *  @return 获取到的文件大小
 */
+ (unsigned long long)fileSizeWithPath:(NSString *)path;

/**
 *  获取文件夹的大小(单位字节)
 *
 *  @param path 文件夹路径
 *
 *  @return 获取到的文件夹的大小
 */
+ (unsigned long long)folderSizeWithPath:(NSString *)path;


/**
 获取用户缓存文件夹大小

 @return 获取到的文件夹的大小 单位 - mb
 */
+ (double)userCacheFolderSize;

/**
 *  删除文件/文件夹
 *
 *  @param filePath 文件路径 -- 全路径
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteFileWithPath:(NSString *)filePath;


/**
 删除用户缓存数据

 @return return value description
 */
+ (BOOL)deleteUserCache;

#pragma mark - 文件存取
/**
 存储Model/object类型 -- 默认路径在documents下
 
 @param modelObject    Model/数组/字典/字符串等
 @param fileName 文件名字  
 */
+ (BOOL)saveModelObject:(id)modelObject fileName:(NSString*)fileName;

/**
 存储Model/object类型 -- 默认路径在documents下并且创建一个文件夹
 
 @param modelObject Model/数组/字典/字符串等
 @param directoryName 文件夹名字
 @param fileName 文件名字
 */
+ (BOOL)saveModelObject:(id)modelObject directoryName:(NSString *)directoryName fileName:(NSString *)fileName;



/**
 保存用户缓存的数据 -- 默认路径在documents下的userCache文件夹下

 @param modelObject Model/数组/字典/字符串等
 @param fileName 文件名字
 @return return value description
 */
+ (BOOL)saveUserCacheModelObject:(id)modelObject  fileName:(NSString *)fileName;


/**
 获取Model/object对象 -- 默认路径在documents下
 
 @param fileName 文件名字

 */
+ (void)getModelObjectByFileName:(NSString*)fileName completeBlock:(NSFileManagerObtainCompleteBlock)completeBlock;


/**
 获取Model/object对象 -- 默认路径在documents下

@param fileName 文件名字
 */
+ (id)getModelObjectByFileName:(NSString*)fileName;



/**
  获取Model/object对象 -- 默认路径在documents下

 @param fileName 文件名字
 @param directoryName 文件夹名字
 @return return value description
 */
+ (id)getModelObjectByFileName:(NSString*)fileName directoryName:(NSString *)directoryName;

/**
 获取Model/object对象 -- 默认路径在documents下
 
 @param fileName 文件名字
 @param directoryName 文件夹名字
 */
+ (void)getModelObjectByFileName:(NSString *)fileName directoryName:(NSString *)directoryName completeBlock:(NSFileManagerObtainCompleteBlock)completeBlock;



/**
 获取Model/object对象 -- 默认路径在documents下的userCache文件夹下

 @param fileName 文件名字
 @param completeBlock completeBlock description
 */
+ (void)getUserCacheModelObjectByFileName:(NSString*)fileName completeBlock:(NSFileManagerObtainCompleteBlock)completeBlock;

/**
 存储NSData图片/视频/录音类型对象 并且创建文件夹
 
 @param fileName 文件名字
 @param directoryName 文件夹名字
 @param data 文件
 */
+ (BOOL)saveDataWithFileName:(NSString *)fileName directoryName:(NSString *)directoryName data:(NSData *)data;


@end
