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
/**
 *  公共富文本
 */
+ (NSAttributedString *)attStringWithString:(NSString *)string keyWord:(NSString *)keyWord;

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor;

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor
                                  lineSpace:(CGFloat)lineSpace;

+ (NSString *)validString:(NSString *)string;

+ (UIImage *)imageWithColor:(UIColor *)color;
@end
