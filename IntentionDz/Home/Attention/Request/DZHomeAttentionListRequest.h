//
//  DZHomeAttentionListRequest.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/7.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseRequest.h"

@interface DZHomeAttentionListRequest : DZBaseRequest
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger homepage_user_id;
@end
