//
//  DZFileCacheManager.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZFileCacheManager : NSObject
//把对象归档存到沙盒里cache路径下
+(BOOL)saveObject:(id)object byFileName:(NSString*)fileName;
//通过文件名从沙河中找到归档对象
+(id)getObjectByFileName:(NSString*)fileName;
//根据名字从沙河中删除
+(void)removeObjectByFileName:(NSString*)fileName;
//把用户偏好设置存到nsuserdefults
+(void)saveUserData:(id)data forKey:(NSString *)key;
//读取用户偏好设置
+(id)readUserDataForKey:(NSString*)key;
//删除用户偏好设置
+(void)removeUserDataForkey:(NSString*)key;

@end
