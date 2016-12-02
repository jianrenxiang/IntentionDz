//
//  DZCustomAleartView.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/1.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZCustomAleartView : UIView

-(void)setUpCancleBlock:(BOOL (^)())cancleBlock;

-(void)setUpSureBlock:(BOOL (^)())touchBlock;

-(void)showInview:(UIView*)view;

-(instancetype)initWithTitle:(NSString*)title cancle:(NSString*)cancle sure:(NSString*)sure;

@end
