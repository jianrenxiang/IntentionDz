//
//  UIViewController+Loading.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/29.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Loading)

-(UIView*)loadingView;

-(void)showLoadingViewWithFrame:(CGRect)frame;

-(void)showLoadingView;

-(void)hideLoadingView;

@end
