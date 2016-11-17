//
//  DZCustomSementView.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZCustomSementView : UIView

-(instancetype)initWithTitles:(NSArray *)itemTitles;
//回调属性
@property(nonatomic,copy) void (^DZCustomSegmentViewBtnClickHandle)(DZCustomSementView *segment,NSString *currentTitle,NSInteger currentIndex);
-(void)clickDefault;
@end
