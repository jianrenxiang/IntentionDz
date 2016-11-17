//
//  UIView+Layer.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)
-(void)setLayerCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderwidth borderColor:(UIColor *)borderColor{
    self.layerCornerRadius=cornerRadius;
    self.layerBorderWidth=borderwidth;
    self.layerBorderColor=borderColor;
    self.layer.masksToBounds=YES;
}
-(void)setLayerCornerRadius:(CGFloat)layerCornerRadius{
    self.layer.cornerRadius=layerCornerRadius;
    [self _config];
}

-(void)setLayerBorderWidth:(CGFloat)layerBorderWidth{
    self.layer.borderWidth=layerBorderWidth;
    [self _config];
}

-(void)setLayerBorderColor:(UIColor *)layerBorderColor{
    self.layer.borderColor=layerBorderColor.CGColor;
    [self _config];
}

-(UIColor*)layerBorderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(CGFloat)layerBorderWidth{
    return self.layer.borderWidth;
}

-(CGFloat)layerCornerRadius{
    return self.layer.cornerRadius;
}



-(void)_config{
    self.layer.masksToBounds=YES;
//    棚格化 ，提高性能
//    设置棚格化后，图层会被渲染成图片，并且缓存，再次使用的时候就不会再次渲染 
    self.layer.rasterizationScale=[UIScreen mainScreen].scale;
    self.layer.shouldRasterize=YES;
}
@end
