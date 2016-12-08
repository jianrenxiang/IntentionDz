//
//  DZDiscoverTopicRequest.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/8.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseRequest.h"

@interface DZDiscoverTopicRequest : DZBaseRequest
@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger mpic;;
@property (nonatomic, assign) NSInteger message_cursor;
@end
