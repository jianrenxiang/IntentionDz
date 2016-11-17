//
//  DZRquestManager.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/16.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZRquestManager.h"
#import "AFURLResponseSerialization.h"
@interface AFHTTPSessionManager (share)

+(instancetype)sharedManager;

@end

@implementation AFHTTPSessionManager (share)

+(instancetype)sharedManager{
    static AFHTTPSessionManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[AFHTTPSessionManager manager];
        _instance.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/plain",@"text/json",@"text/javascript",@"text/html", nil];
    });
    return _instance;
}

@end

@implementation DZRquestManager
//post请求
+(void)POST:(NSString*)URLString param:(id)param ReponseSeializeType:(DZRequstReponseSeializerType)seialzerType success:(void (^)(id reponseObject))success failure:(void(^)(NSError *error))failure;{
    AFHTTPSessionManager *manage=[AFHTTPSessionManager sharedManager];
    [manage.requestSerializer setValue:[self cookie] forHTTPHeaderField:@"Authorization"];
    if (seialzerType!=DZRequstReponseSeializerTypeJSON||seialzerType!=DZRequstReponseSeializerTypeDefualt) {
        manage.responseSerializer=[self responseSeialzerWithSeialzerType:seialzerType];
    }
    //post请求要设置https证书
    AFSecurityPolicy *policy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    policy.allowInvalidCertificates=YES;
    manage.securityPolicy=policy;
    [manage POST:URLString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//get请求
+(void)GET:(NSString*)URLString param:(id)param reponseSeialzerTy:(DZRequstReponseSeializerType)seialzerType success:(void(^)(id reponseObject))success failure:(void(^)(id reponseObject))failure;{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager sharedManager];
//    设置cookie
    [manager.requestSerializer setValue:[self cookie] forHTTPHeaderField:@"Cookie"];
//    假设数类型不是json就加个case去判断,通过我们给的类型enum去替换成afhttp的sealizer类型
    if (seialzerType!=DZRequstReponseSeializerTypeJSON||seialzerType!=DZRequstReponseSeializerTypeDefualt) {
        manager.responseSerializer=[self responseSeialzerWithSeialzerType:seialzerType];
    }
    [manager GET:URLString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//上传

+(void)POST:(NSString *)URLString param:(id)param reponseSeialzerType:(DZRequstReponseSeializerType)reponseSeialzer constructingBodyWithBlock:(void(^)(id<AFMultipartFormData>formDate))block success:(void(^)(id reponseObject))success failure:(void (^)(NSError *error))failure;{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager sharedManager];
//    上传文件肯定是没有请求头设置
//    manager.requestSerializer setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>
    if (reponseSeialzer!=DZRequstReponseSeializerTypeDefualt||reponseSeialzer!=DZRequstReponseSeializerTypeJSON) {
        manager.responseSerializer=[self responseSeialzerWithSeialzerType:reponseSeialzer];
    }
    [manager POST:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//+(void)cancelAllRequest;{
//    
//}

+(AFHTTPResponseSerializer*)responseSeialzerWithSeialzerType:(DZRequstReponseSeializerType)seializerType{
    switch (seializerType) {
        case DZRequstReponseSeializerTypeDefualt:
            return [AFJSONResponseSerializer serializer];
            break;
        case DZRequstReponseSeializerTypeJSON:
            return [AFJSONResponseSerializer serializer];
            break;
        case DZRequstReponseSeializerTypeXML:
            return [AFXMLParserResponseSerializer serializer];
            break;
        case DZRequstReponseSeializerTypePlist:
            return [AFPropertyListResponseSerializer serializer];
            break;
        case DZRequstReponseSeializerTypeCompound:
            return [AFCompoundResponseSerializer serializer];
            break;
        case DZRequstReponseSeializerTypeDate:
            return [AFHTTPResponseSerializer serializer];
            break;
        case DZRequstReponseSeializerTypeImage:
            return [AFImageResponseSerializer serializer];
            break;

        default:
            return [AFJSONResponseSerializer serializer];
            break;
    }
}

+ (NSString *)cookie {
    
    return @"_ga=GA1.2.732729183.1467731127; install_id=5316804410; login_flag=319157cead347271ef233ba429923e3b; qh[360]=1; sessionid=b391787a2cd16be0f914259f0cf829a4; sid_guard=\"b391787a2cd16be0f914259f0cf829a4|1473218826|2591916|Fri\054 07-Oct-2016 03:25:42 GMT\"; sid_tt=b391787a2cd16be0f914259f0cf829a4; uuid=\"w:9ce15113cb34468795d7aff3edddd670";

}
@end
