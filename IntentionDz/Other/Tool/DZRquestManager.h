//
//  DZRquestManager.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/16.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef NS_ENUM(NSUInteger,DZRequstReponseSeializerType){
    DZRequstReponseSeializerTypeDefualt,
    DZRequstReponseSeializerTypeJSON,
    DZRequstReponseSeializerTypeXML,
    DZRequstReponseSeializerTypePlist,
    DZRequstReponseSeializerTypeCompound,
    DZRequstReponseSeializerTypeImage,
    DZRequstReponseSeializerTypeDate,
};
@interface DZRquestManager : NSObject
//post请求
+(void)POST:(NSString*)URLString param:(id)param ReponseSeializeType:(DZRequstReponseSeializerType)seialzerType success:(void (^)(id reponseObject))success failure:(void(^)(NSError *error))failure;

//get请求
+(void)GET:(NSString*)URLString param:(id)param reponseSeialzerTy:(DZRequstReponseSeializerType)seialzerType success:(void(^)(id reponseObject))success failure:(void(^)(id reponseObject))failure;

//上传

+(void)POST:(NSString *)URLString param:(id)param reponseSeialzerType:(DZRequstReponseSeializerType)reponseSeialzer constructingBodyWithBlock:(void(^)(id<AFMultipartFormData>formDate))block success:(void(^)(id reponseObject))success failure:(void (^)(NSError *error))failure;

+(void)cancelAllRequest;

@end
