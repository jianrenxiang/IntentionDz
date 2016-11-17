//
//  DZHomeHeaderOptionView.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/16.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZHomeHeaderOptionView : UIView
//标题组
@property(nonatomic,strong)NSArray <NSString *>*titles;
//点击item回调
@property(nonatomic,copy) void(^homeHeaderOpetionalViewItemClickHandle)(DZHomeHeaderOptionView *optionView,NSString *title,NSInteger currentIndex);
//偏移量
@property(nonatomic,assign)CGPoint contentOffset;
@end
