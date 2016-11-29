//
//  DZUtils.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/29.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZUtils.h"
#import "MJRefresh.h"
@implementation DZUtils
/** 开始下拉刷新 */
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;{
    [scrollView.mj_header beginRefreshing];
}
/**停止下拉刷新*/
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header endRefreshing];
}

@end
