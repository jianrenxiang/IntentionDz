//
//  DZHomeDynamicRequest.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/1.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseRequest.h"

@interface DZHomeDynamicRequest : DZBaseRequest

/** bury 踩 digg 顶*/
@property (nonatomic, copy) NSString *action;
@property (nonatomic, assign) NSInteger group_id;

@end
