//
//  DZAnimationManager.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/1.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZAnimationManager.h"

@implementation DZAnimationManager
+ (void)addTransformAnimationForView:(UIView *)view;{
    view.transform=CGAffineTransformMakeScale(0.97, 0.97);
    [UIView animateWithDuration:0.12 animations:^{
        view.transform=CGAffineTransformIdentity;
        view.alpha=1;
    }];
}
+ (void)shakeView:(UIView*)viewToShake {
    CGFloat t = 4.0;
   CGAffineTransform translateRight= CGAffineTransformScale(CGAffineTransformIdentity, t, 0);
    CGAffineTransform translateLetf=CGAffineTransformScale(CGAffineTransformIdentity, -t, 0);
    viewToShake.transform=translateLetf;
    [UIView animateWithDuration:0.07 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
               viewToShake.transform =CGAffineTransformIdentity;
            }completion:nil];
        }
    }];
}
@end
