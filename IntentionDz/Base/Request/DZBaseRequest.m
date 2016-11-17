//
//  DZBaseRequest.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/16.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseRequest.h"
#import "MJExtension.h"
#import "AFNetworkReachabilityManager.h"
#import "DZRquestManager.h"
#import "NSString+Addition.h"
#import "NSNotificationCenter+Addition.h"
#import "DZCommonConstant.h"
@implementation DZBaseRequest

+(instancetype)dz_request;{
    return [[self alloc]init];
}

+(instancetype)dz_requestWithUrl:(NSString*)url;{
    return [self dz_requestWithUrl:url isPost:NO];
}

+(instancetype)dz_requestWithUrl:(NSString *)url isPost:(BOOL)ispost;{
    return [self dz_requestWithUrl:url isPost:NO delegate:nil];
}
//以上三个方法都是假的，实质就执行下面方法
+(instancetype)dz_requestWithUrl:(NSString *)url isPost:(BOOL)ispost delegate:(id <DZBaseRequestReponseDelegate>)dz_delegate;{
    DZBaseRequest *request=[self dz_request];
    request.dz_url=url;
    request.dz_isPost=ispost;
    request.dz_delegate=dz_delegate;
    return request;
}

-(void)dz_sendRequest;{
    [self dz_sendRequestWithCompletion:nil];
}

-(void)dz_sendRequestWithCompletion:(DZAPIDicCompletion)completion;{
    NSString *urlStr=self.dz_url;
    if (urlStr.length==0) {
        return;
    }
    NSDictionary *param=[self params];
    //poset请求
    if (self.dz_isPost) {
        if (self.dz_imageArr.count==0) {
            [DZRquestManager POST:[urlStr noWhiteSpaceString] param:param ReponseSeializeType:DZRequstReponseSeializerTypeJSON success:^(id reponseObject) {
                [self handleReponse:reponseObject completion:completion];
            } failure:^(NSError *error) {
                
            }];
        }
    }else{
        [DZRquestManager GET:[urlStr noWhiteSpaceString] param:param reponseSeialzerTy:DZRequstReponseSeializerTypeJSON success:^(id reponseObject) {
            [self handleReponse:reponseObject completion:completion];
        } failure:^(id reponseObject) {
            
        }];
    }
    if (self.dz_imageArr.count) {
        [DZRquestManager POST:[urlStr noWhiteSpaceString] param:param reponseSeialzerType:DZRequstReponseSeializerTypeJSON constructingBodyWithBlock:^(id<AFMultipartFormData> formDate) {
            NSInteger imgCount=0;
            for (UIImage *image in self.dz_imageArr) {
                NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss:SSS";
//                图片命名规则 时间+第几张
                NSString *fileName=[NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
                [formDate appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:fileName mimeType:@"image/png"];
            }
        } success:^(id reponseObject) {
            [self handleReponse:reponseObject completion:completion];
        } failure:^(NSError *error) {
            
        }];
    }
}

-(void)handleReponse:(id)responseObject completion:(DZAPIDicCompletion)completion{
    if ([responseObject[@"message"]isEqualToString:@"retry"]) {
        [self dz_sendRequestWithCompletion:completion];
        return;
    }
    BOOL success=[responseObject[@"message"]isEqualToString:@"success"];
    if (completion) {
        completion(responseObject[@"data"],success,@"");
    }else if(self.dz_delegate){
        if ([self.dz_delegate respondsToSelector:@selector(requsetSuccessReponse:reponse:message:)]) {
            [self.dz_delegate requsetSuccessReponse:success reponse:responseObject message:@""];
        }
    }
    [NSNotificationCenter postNotification:kDZRequestSuccessNotification];
}

- (NSDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"tag"] = @"joke";
    params[@"iid"] = @"5316804410";
    params[@"os_version"] = @"9.3.4";
    params[@"os_api"] = @"18";
    
    params[@"app_name"] = @"joke_essay";
    params[@"channel"] = @"App Store";
    params[@"device_platform"] = @"iphone";
    params[@"idfa"] = @"832E262C-31D7-488A-8856-69600FAABE36";
    params[@"live_sdk_version"] = @"120";
    
    params[@"vid"] = @"4A4CBB9E-ADC3-426B-B562-9FC8173FDA52";
    params[@"openudid"] = @"cbb1d9e8770b26c39fac806b79bf263a50da6666";
    params[@"device_type"] = @"iPhone 6 Plus";
    params[@"version_code"] = @"5.5.0";
    params[@"ac"] = @"WIFI";
    params[@"screen_width"] = @"1242";
    params[@"device_id"] = @"10752255605";
    params[@"aid"] = @"7";
    params[@"count"] = @"50";
    params[@"max_time"] = [NSString stringWithFormat:@"%.2f", [[NSDate date] timeIntervalSince1970]];
    
    [params addEntriesFromDictionary:self.mj_keyValues];
    
    if ([params.allKeys containsObject:@"nh_delegate"]) {
        [params removeObjectForKey:@"nh_delegate"];
    }
    if ([params.allKeys containsObject:@"nh_isPost"]) {
        [params removeObjectForKey:@"nh_isPost"];
    }
    if ([params.allKeys containsObject:@"nh_url"]) {
        [params removeObjectForKey:@"nh_url"];
    }
    if (self.dz_imageArr.count == 0) {
        if ([params.allKeys containsObject:@"nh_imageArray"]) {
            [params removeObjectForKey:@"nh_imageArray"];
        }
    }
    return params;
}

-(void)setDz_url:(NSString *)dz_url{
    if (dz_url.length==0||[dz_url isKindOfClass:[NSNull class]]) {
        return;
    }
    _dz_url=dz_url;
}

@end
