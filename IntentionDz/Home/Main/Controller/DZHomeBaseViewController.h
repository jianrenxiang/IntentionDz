//
//  DZHomeBaseViewController.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/18.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseTableViewController.h"

@class DZBaseRequest;
@interface DZHomeBaseViewController :DZBaseTableViewController

-(instancetype)initWithUrl:(NSString *)url;

-(instancetype)initWitnRequest:(DZBaseRequest *)request;

@property(nonatomic,copy) void (^hoemBaseControllerFinishRequestDataHandle)(NSInteger dataCount);


@end
