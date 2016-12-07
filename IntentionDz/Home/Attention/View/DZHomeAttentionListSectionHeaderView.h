//
//  DZHomeAttentionListSectionHeaderView.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/6.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "NHBaseTableHeaderFooterView.h"

@interface DZHomeAttentionListSectionHeaderView : NHBaseTableHeaderFooterView
/** 提示文字*/
@property (nonatomic, weak) NSString *tipText;
/** 文字颜色*/
@property (nonatomic, strong) UIColor *textColor;
/** 提示文字标签*/
@property (nonatomic, weak) UILabel *tipL;
@end
