//
//  DZBaseRequest.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/16.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DZBaseRequestReponseDelegate <NSObject>

@required

-(void)requsetSuccessReponse:(BOOL)success reponse:(id)reponse message:(NSString*)message;

@end

typedef void (^DZAPIDicCompletion)(id reponse,BOOL success,NSString *message);

@interface DZBaseRequest : NSObject

@property(nonatomic,copy)NSString *dz_url;

@property(nonatomic,assign)BOOL dz_isPost;
//上传图片还需要一个图片数组
@property(nonatomic,strong)NSArray <UIImage *>*dz_imageArr;

@property(nonatomic,weak)id<DZBaseRequestReponseDelegate> dz_delegate;

//需要提供一些接口

+(instancetype)dz_request;

+(instancetype)dz_requestWithUrl:(NSString*)url;

+(instancetype)dz_requestWithUrl:(NSString *)url isPost:(BOOL)ispost;

+(instancetype)dz_requestWithUrl:(NSString *)url isPost:(BOOL)ispost delegate:(id <DZBaseRequestReponseDelegate>)dz_delegate;

//开始请求设置了代理，不需要回调用该方法
-(void)dz_sendRequest;
//需要回调
-(void)dz_sendRequestWithCompletion:(DZAPIDicCompletion)completion;
@end
