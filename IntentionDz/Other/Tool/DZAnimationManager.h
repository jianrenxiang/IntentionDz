//
//  DZAnimationManager.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/1.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZAnimationManager : NSObject
/**
 *  为某个视图添加
 */
+ (void)addTransformAnimationForView:(UIView *)view;
/**
 *  让某一个视图抖动
 *
 *  @param viewToShake 需要抖动的视图
 */
+ (void)shakeView:(UIView*)viewToShake;
@end
