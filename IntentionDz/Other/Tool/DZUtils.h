//
//  DZUtils.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/29.
//  Copyright © 2016年 com.ews. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface DZUtils : NSObject
/** 开始下拉刷新 */
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;
/**  停止下拉刷新 */
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView;
@end
