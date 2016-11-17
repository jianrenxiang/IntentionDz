//
//  DZDefaultHeader.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#ifndef DZDefaultHeader_h
#define DZDefaultHeader_h

/**
 *  弱指针
 */
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf=self;

#pragma mark- 颜色
#define kWhiteColor [UIColor whiteColor]
#define tabbarBottonColor [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f]
#define tabbarBottonNormalTextColor [UIColor colorWithRed:0.62f green:0.62f blue:0.62f alpha:1]
#define tabbarBottonSelectTextColor [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1]
#define kCommonTintColor [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f]
#define kSegmentNormalColor [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f]
#define kCommonBgColor [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f]
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGBColor(r,g,b) kRGBAColor(r,g,b,1.0f)
#define kSeperatorColor kRGBColor(234,237,240)
#define kLeftMargin 15
#pragma mark- 字体大小
#define kFont(size) [UIFont systemFontOfSize:size]
#define kLineHeight (1 / [UIScreen mainScreen].scale)
/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#pragma mark --系统UI
#define kTopBarHeight 64
#define kTabBarHeight 49
#endif /* DZDefaultHeader_h */