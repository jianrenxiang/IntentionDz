//
//  DZDiscoverTopicViewController.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/8.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseViewController.h"
@class NHDiscoverCategoryElement;
@interface DZDiscoverTopicViewController : DZBaseViewController

/**
 * 构造方法
 * catogoryId : 分类Id
 */
- (instancetype)initWithCatogoryId:(NSInteger)categoryId;

- (instancetype)initWithCategoryElement:(NHDiscoverCategoryElement *)element;
@end
