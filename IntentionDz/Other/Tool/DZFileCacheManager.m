//
//  DZFileCacheManager.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZFileCacheManager.h"
#import "NSFileManager+Paths.h"
@implementation DZFileCacheManager
//把对象归档存到沙盒里cache路径下
+(BOOL)saveObject:(id)object byFileName:(NSString*)fileName;{
    NSString *path=[self appendFilePath:fileName];
    path=[path stringByAppendingString:@".archive"];
    BOOL success=[NSKeyedArchiver archiveRootObject:object toFile:path];
    return success;
}
//通过文件名从沙河中找到归档对象
+(id)getObjectByFileName:(NSString*)fileName;{
    NSString *path=[self appendFilePath:fileName];
    path=[path stringByAppendingString:@".archive"];
    id obj=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return obj;
}
//根据名字从沙河中删除
+(void)removeObjectByFileName:(NSString*)fileName;{
    NSString *path=[self appendFilePath:fileName];
    path=[path stringByAppendingString:@".archive"];
    [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
}

+(NSString *)appendFilename:(NSString*)fileName{
    NSString *cachesPath=[NSFileManager cachesPath];
    if ([[NSFileManager defaultManager]fileExistsAtPath:cachesPath isDirectory:nil]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:cachesPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return cachesPath;
}

//把用户偏好设置存到nsuserdefults
+(void)saveUserData:(id)data forKey:(NSString *)key;{
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//读取用户偏好设置
+(id)readUserDataForKey:(NSString*)key;{
    id obj=[[NSUserDefaults standardUserDefaults]valueForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    return obj;
}
//删除用户偏好设置
+(void)removeUserDataForkey:(NSString*)key;{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSString*)appendFilePath:(NSString*)fileName{
    NSString *cachesPath=[NSFileManager cachesPath];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",cachesPath,fileName];
    //isDirectory 可以为文件名 判断是否为文件夹
    if (![[NSFileManager defaultManager]fileExistsAtPath:filePath isDirectory:nil]) {
        //        创建文件
        [[NSFileManager defaultManager]createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return filePath;
}


@end
