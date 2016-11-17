//
//  UIView+Layer.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)

-(void)setLayerCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderwidth borderColor:(UIColor *)borderColor;
//半径
@property(nonatomic,assign)CGFloat layerCornerRadius;
//线宽
@property(nonatomic,assign)CGFloat layerBorderWidth;
//线色
@property(nonatomic,strong)UIColor* layerBorderColor;


@end
