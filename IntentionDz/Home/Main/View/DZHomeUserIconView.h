//
//  DZHomeUserIconView.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/7.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZHomeUserIconView : UIView

+ (instancetype)iconView;

/** 头像链接*/
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, strong) UIImage *image;

/** 点击头像回调*/
@property (nonatomic, copy) void(^homeUserIconViewDidClickHandle)(DZHomeUserIconView *iconView);
@end
