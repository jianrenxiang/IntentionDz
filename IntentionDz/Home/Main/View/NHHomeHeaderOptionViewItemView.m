//
//  NHHomeHeaderOptionViewItemView.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/16.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "NHHomeHeaderOptionViewItemView.h"

@implementation NHHomeHeaderOptionViewItemView

-(void)setProgress:(CGFloat)progress{
    _progress=progress;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [_fillColor set];
    CGRect newRect=rect;
    newRect.size.width=rect.size.width*self.progress;
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);
}
@end
