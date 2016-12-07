//
//  DZCustomCommonEmptyView.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/7.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZCustomCommonEmptyView : UIView
@property (nonatomic, weak) UIImageView *topTipImageView;
@property (nonatomic, weak) UILabel *firstL;
@property (nonatomic, weak) UILabel *secondL;
- (instancetype)initWithTitle:(NSString *)title
                  secondTitle:(NSString *)secondTitle
                     iconname:(NSString *)iconname;
- (instancetype)initWithAttributedTitle:(NSMutableAttributedString *)attributedTitle
                  secondAttributedTitle:(NSMutableAttributedString *)secondAttributedTitle
                               iconname:(NSString *)iconname;
- (void)showInView:(UIView *)view;
@end
