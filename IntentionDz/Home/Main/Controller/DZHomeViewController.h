//
//  DZHomeViewController.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseViewController.h"
@class DZServiceListRequest;
@interface DZHomeViewController :DZBaseViewController
@property(nonatomic,strong)NSArray <DZServiceListRequest *>*models;
@end
