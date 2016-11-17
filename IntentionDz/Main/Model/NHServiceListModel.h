//
//  NHServiceListModel.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/16.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "NHBaseModel.h"

@interface NHServiceListModel : NHBaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger refresh_interval;
@end
