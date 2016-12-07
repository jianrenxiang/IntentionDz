//
//  NHBaseModel.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "NHBaseModel.h"
#import "MJExtension.h"
#import "DZFileCacheManager.h"

@implementation NHBaseModel
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID":@"id",
             @"desc":@"description",
             @"responseData" : @"data"
             };
}
-(void)archvie;{
    [DZFileCacheManager saveObject:self byFileName:[self.class description]];
}

-(id)unarchview;{
    id obj=[DZFileCacheManager getObjectByFileName:[self.class description]];
    return obj;
}

-(void)remove;{
    [DZFileCacheManager removeObjectByFileName:[self.class description]];
    
}

+(NSMutableArray*)modelArrayWithDictArray:(NSArray*)response;{
    if ([response isKindOfClass:[NSArray class]]) {
        NSMutableArray *array=[self mj_objectArrayWithKeyValuesArray:response];
        return array;
    }
    return [NSMutableArray new];
}

+(id)modelWithDictionary:(NSDictionary*)dictionary;{
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:dictionary];
    }
    return [[self alloc]init];
}

+(void)setUpModelClassInArrayWithContainDict:(NSDictionary*)dict;{
    if (dict.allKeys.count==0) {
        return;
    }
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return dict;
    }];
}

+(id)modelArrayWithDictArray:(NSArray*)response containDict:(NSDictionary*)dict;{
    if (dict==nil) {
        dict=[NSMutableDictionary new];
    }
    [self setUpModelClassInArrayWithContainDict:dict];
    return [self modelWithDictionary:dict];
}
@end
