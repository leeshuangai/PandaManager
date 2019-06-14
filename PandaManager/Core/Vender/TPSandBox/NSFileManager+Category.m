//
//  NSFileManager+Category.m
//  TJFileManager
//
//  Created by lish on 2017/8/1.
//  Copyright © 2017年 lish. All rights reserved.
//

#import "NSFileManager+Category.h"
static NSString * const UserCacheDirectoryName = @"userCache";
@implementation NSFileManager (Category)
#pragma mark - 获取沙盒目录相关
// 获取沙盒根目录
+ (NSString *)sanBoxHomeDirectory
{
    NSString *path = NSHomeDirectory();
    return path;
}

// 获取documents路径
+ (NSString *)sanBoxDocumentsDirectory
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return path;
    
}

// 获取documents目录下指定文件名的全路径
+ (NSString *)sanBoxFilePathWithFileName:(NSString *)fileName
{
    NSString *path = [[self sanBoxDocumentsDirectory] stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    
    return path;
}

// 获取tmp路径
+ (NSString *)sanBoxTmpDirectory
{
    NSString *path = NSTemporaryDirectory();
    return path;
}

// 获取cache路径
+ (NSString *)sanBoxCacheDirectory
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return path;
}

// 获取library路径
+ (NSString *)sanBoxLibraryDirectory
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    return path;
}


#pragma mark - 文件操作相关
/**
 *  沙盒documents目录下创建新的文件夹
 *
 *  @param directoryName 文件夹名字
 *
 *  @return 创建文件夹成功的路径 不成功为nil
 */
+ (BOOL)createNewDirectoryWithName:(NSString *)directoryName
{
    NSString *fullPath = [self sanBoxFilePathWithFileName:directoryName];
    DDLog(@"fullPath --- %@",fullPath);
    
    // 创建文件夹
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&error];
    
    // 创建文件夹失败
    if (error) {
        DDLog(@"创建文件夹失败:%@",error);
    }else{
        DDLog(@"创建文件夹成功,路径:%@",fullPath);
    }
    
    return success;
    
    
}

/**
 *  判断文件是否存在
 *
 *  @param filePath 文件路径 -- 全路径
 *
 *  @return 是否存在
 */
+ (BOOL)fileExistWithPath:(NSString *)filePath
{
    BOOL isDirectory = NO;
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL exist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    if (exist) {
        if (isDirectory) {
            DDLog(@"此文件是一个文件夹,路径:%@",filePath);
        }else{
            DDLog(@"此文件是一个文件,路径:%@",filePath);
        }
    }
    
    return exist;
}


/**
 *  获取文件的大小(单位字节，转换成kb需要除以1024)
 *
 *  @param path 文件路径
 *
 *  @return 获取到的文件大小
 */
+ (unsigned long long)fileSizeWithPath:(NSString *)path
{
    if ([self fileExistWithPath:path]) {
        unsigned long long size = [[self fileInfoWithPath:path] fileSize];
        DDLog(@"获取文件大小:%llu 路径:%@",size,path);
        return size;
    }else{
        DDLog(@"文件不存在,路径:%@",path);
        return 0;
    }
}

/**
 *  获取文件夹的大小(单位字节)
 *
 *  @param path 文件夹路径
 *
 *  @return 获取到的文件夹的大小
 */
+ (unsigned long long)folderSizeWithPath:(NSString *)path
{
    BOOL exist = [self fileExistWithPath:path];
    
    if (!exist) {
        DDLog(@"文件不存在,路径:%@",path);
        return 0;
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        NSEnumerator *fileEnumetator = [[manager subpathsAtPath:path] objectEnumerator];
        
        unsigned long long size = 0;
        NSString *fileName = @"";
        while (fileName = [fileEnumetator nextObject]) {
            NSString *fileFullPath = [path stringByAppendingPathComponent:fileName];
            size += [self fileSizeWithPath:fileFullPath];
        }
        
        DDLog(@"获取文件夹的大小:%llu 路径:%@",size,path);
        return size;
    }
}
/**
 获取用户缓存文件夹大小 单位 - mb
 
 @return return value description
 */
+ (double)userCacheFolderSize {
    
  float userCacheFolderSize = [self fileSizeWithPath:[NSString stringWithFormat:@"%@/%@",[self sanBoxDocumentsDirectory],UserCacheDirectoryName]];
    
    return [NSString stringWithFormat:@"%.2f",userCacheFolderSize/1024/1024].doubleValue;
    
}
/**
 *  删除文件/文件夹
 *
 *  @param filePath 文件路径
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteFileWithPath:(NSString *)filePath
{
    if (![self fileExistWithPath:filePath]) {
        DDLog(@"文件不存在,路径:%@",filePath);
        return NO;
    }
    
    NSError *error = nil;
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL success = [manager removeItemAtPath:filePath error:&error];
    
    if (error) {
        DDLog(@"删除文件失败:%@",error);
    }else{
        DDLog(@"删除文件成功,路径:%@",filePath);
    }
    
    return success;
}
+ (BOOL)deleteUserCache {
    
    return  [self deleteFileWithPath:[NSString stringWithFormat:@"%@/%@",[self sanBoxDocumentsDirectory],UserCacheDirectoryName]];
}

/**
 *  获取文件信息
 *
 *  @param path 文件路径
 *
 *  @return 获取到的文件信息
 */
+ (NSDictionary *)fileInfoWithPath:(NSString *)path
{
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileInfo = [fileManager attributesOfItemAtPath:path error:&error];
    
    if (error) {
        DDLog(@"获取文件信息失败:%@",error);
    }else{
        DDLog(@"获取文件信息成功,内容:%@",fileInfo);
    }
    
    return fileInfo;
}

#pragma mark - 文件存取
/**
 存储Model/object类型 -- 默认路径在documents下
 
 @param modelObject    Model/数组/字典/字符串
 @param fileName 文件名字  带后缀 @"arr.plsit"
 */
+ (BOOL)saveModelObject:(id)modelObject fileName:(NSString *)fileName {
    
    NSString *path  = [self sanBoxFilePathWithFileName:fileName];
    DDLog(@"存model路径-- %@",path);
    BOOL succeed = [NSKeyedArchiver archiveRootObject:modelObject toFile:path];
    return succeed;
}

/**
 存储Model/object类型 -- 默认路径在documents下并且创建一个文件夹
 
 @param modelObject Model/数组/字典/字符串等
 @param directoryName 文件夹名字
 @param fileName 文件名字
 */
+ (BOOL)saveModelObject:(id)modelObject directoryName:(NSString *)directoryName fileName:(NSString *)fileName {
    
    [NSFileManager  createNewDirectoryWithName:directoryName];
    NSString *path = [self sanBoxFilePathWithFileName:[NSString stringWithFormat:@"%@/%@",directoryName,fileName]];
    DLog(@"存model路径-- %@",path);
    BOOL succeed = [NSKeyedArchiver archiveRootObject:modelObject toFile:path];
    return succeed;
}

+ (BOOL)saveUserCacheModelObject:(id)modelObject fileName:(NSString *)fileName {
    
    
    return [self saveModelObject:modelObject directoryName:UserCacheDirectoryName fileName:fileName];
    
}

/**
 获取Model/object对象 -- 默认路径在documents下
 
 @param fileName 文件名字 带后缀 @"arr.plsit"

 */
+ (void)getModelObjectByFileName:(NSString*)fileName completeBlock:(NSFileManagerObtainCompleteBlock)completeBlock
{
    NSString *path  = [self sanBoxFilePathWithFileName:fileName];
    
    if (![self fileExistWithPath:path]) {
        DDLog(@"文件不存在,路径:%@",path);
        completeBlock(NO,nil);
    }
    else{
        DDLog(@"文件存在,路径:%@",path);
        completeBlock(YES,[NSKeyedUnarchiver unarchiveObjectWithFile:path]);
    }

}

+ (id)getModelObjectByFileName:(NSString*)fileName  {
    
    
    NSString *path  = [self sanBoxFilePathWithFileName:fileName];
    
    if (![self fileExistWithPath:path]) {
        DDLog(@"文件不存在,路径:%@",path);
        return nil;
    }
    else{
        DDLog(@"文件存在,路径:%@",path);
        
        return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}
+ (id)getModelObjectByFileName:(NSString*)fileName directoryName:(NSString *)directoryName {
    
   NSString *path  = [NSString stringWithFormat:@"%@/%@",directoryName,fileName];
    
    return  [self getModelObjectByFileName:path];
    
}
/**
 获取Model/object对象 -- 默认路径在documents下
 
 @param fileName 文件名字
 @param directoryName 文件夹名字

 */
+ (void)getModelObjectByFileName:(NSString *)fileName directoryName:(NSString *)directoryName completeBlock:(NSFileManagerObtainCompleteBlock)completeBlock {
    
    
     [NSFileManager getModelObjectByFileName:[NSString stringWithFormat:@"%@/%@",directoryName,fileName] completeBlock:^(BOOL succeed, id result) {
         
         completeBlock(succeed,result);
         
     }];
}

+ (void)getUserCacheModelObjectByFileName:(NSString*)fileName completeBlock:(NSFileManagerObtainCompleteBlock)completeBlock {
    
    
    [self getModelObjectByFileName:fileName directoryName:UserCacheDirectoryName completeBlock:^(BOOL succeed, id result) {
        completeBlock(succeed,result);
    }];
    
}


/**
 存储NSData图片/视频/录音类型对象 并且创建文件夹
 
 @param fileName 文件名字 带后缀 -- @"pic.png"
 @param directoryName 文件夹名字
 @param data 文件
 */
+ (BOOL)saveDataWithFileName:(NSString *)fileName directoryName:(NSString *)directoryName data:(NSData *)data {
    
    [NSFileManager  createNewDirectoryWithName:directoryName];
    NSString *path = [self sanBoxFilePathWithFileName:[NSString stringWithFormat:@"%@/%@",directoryName,fileName]];
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    
    return result;
}

@end
