//
//  DZDiscoverTableViewCell.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/8.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseTableViewCell.h"
@class NHDiscoverCategoryElement;
@interface DZDiscoverTableViewCell : DZBaseTableViewCell
/** 设置数据*/
@property (nonatomic, strong) NHDiscoverCategoryElement *elementModel;

- (void)setElementModel:(NHDiscoverCategoryElement *)elementModel keyWord:(NSString *)keyWord;
@end
