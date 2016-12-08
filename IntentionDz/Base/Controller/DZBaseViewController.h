//
//  DZBaseViewController.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZBaseViewController : UIViewController
/** 加载中*/
- (void)showLoadingAnimation;
- (void)pushVc:(UIViewController *)vc ;
- (void)presentVc:(UIViewController *)vc;
- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;
- (void)addChildVc:(UIViewController *)childVc;
- (void)removeChildVc:(UIViewController *)childVc;
@end
