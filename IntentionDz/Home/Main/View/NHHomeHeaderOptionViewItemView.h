//
//  NHHomeHeaderOptionViewItemView.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/16.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHHomeHeaderOptionViewItemView : UILabel
/**
 *  填充颜色
 */
@property(nonatomic,strong)UIColor *fillColor;
/**
 *  滑动条
 */
@property(nonatomic,assign)CGFloat progress;
@end
