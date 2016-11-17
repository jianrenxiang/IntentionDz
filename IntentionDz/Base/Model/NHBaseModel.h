//
//  NHBaseModel.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHBaseModel : NSObject

//归档存入模式
-(void)archvie;
//解档，去除模型
-(id)unarchview;
//移除存储中的模型
-(void)remove;
//字典数组模型转数组
+(NSMutableArray*)modelArrayWithDictArray:(NSArray*)response;
//字典转模型
+(instancetype)modelWithDictionary:(NSDictionary*)dictionary;
//模型包含模型数组
+(void)setUpModelClassInArrayWithContainDict:(NSDictionary*)dict;
//字典数组转模型数组
+(NSMutableArray*)modelArrayWithDictArray:(NSArray*)response containDict:(NSDictionary*)dict;
@end
