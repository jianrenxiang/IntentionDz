//
//  DZDynamicDetailRequest.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/2.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseRequest.h"

@interface DZDynamicDetailRequest : DZBaseRequest
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSString *sort;
@property (nonatomic, assign) NSInteger group_id;
@end
