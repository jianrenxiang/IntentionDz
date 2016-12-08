//
//  DZDiscoverHeaderView.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/8.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZDiscoverHeaderViewViewCell,NHDiscoverRotate_bannerElementBanner_url_URL,NHDiscoverRotate_bannerElement;
@interface DZDiscoverHeaderView : UIView
/** 数据源*/
@property (nonatomic, strong) NSArray <NHDiscoverRotate_bannerElement *>*modelArray;
/** 点击回调*/
@property (nonatomic, copy) void(^discoverHeaderViewGoToPageHandle)(DZDiscoverHeaderViewViewCell *cell, NHDiscoverRotate_bannerElement *bannerUrlModel);

@end
