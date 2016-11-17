//
//  DZCustomSementView.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZCustomSementView.h"
#import "UIView+Layer.h"
@interface DZCustomSementView ()

{
    NSArray *_segmentsArr;
    UIButton *_selectButton;
    
}
@end

@implementation DZCustomSementView

-(instancetype)initWithTitles:(NSArray *)itemTitles{
    if ([super init]) {
        _segmentsArr=itemTitles;
        self.layerCornerRadius=3.0;
        self.layerBorderColor=kCommonTintColor;
        self.layerBorderWidth=1.0;
        [self setUpViews];
    }
    return self;
}

-(void)select:(id)sender{
    
}

-(void)setUpViews{
    if (_segmentsArr.count>0) {
        NSInteger i=0;
        for (id obj in _segmentsArr) {
            if ([obj isKindOfClass:[NSString class]]) {
                NSString *objStr=(NSString*)obj;
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:btn];
                [btn setTitle:objStr forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [btn setTitleColor:kSegmentNormalColor forState:UIControlStateNormal];
                btn.titleLabel.font=kFont(16);
                i=i+1;
                btn.tag=i;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.adjustsImageWhenDisabled=NO;
                btn.adjustsImageWhenHighlighted=NO;
            }
        }
        
    }
}

-(void)btnClick:(UIButton*)btn{
    _selectButton.backgroundColor=kCommonBgColor;
    btn.backgroundColor=[UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    _selectButton.selected=NO;
    btn.selected=YES;
    _selectButton=btn;
    NSString *title=btn.currentTitle;
    if (self.DZCustomSegmentViewBtnClickHandle) {
        self.DZCustomSegmentViewBtnClickHandle(self,title,btn.tag-1);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (_segmentsArr.count>0) {
        CGFloat btnW=self.width/_segmentsArr.count;
        for (int i=0; i<_segmentsArr.count; i++) {
            UIButton *btn=(UIButton*)[self viewWithTag:i+1];
            btn.frame=CGRectMake(btnW*i, 0, btnW, self.height);
        }
    }
}

-(void)clickDefault{
    if (_segmentsArr.count==0) {
        return;
    }
    [self btnClick:[self viewWithTag:1]];
}

@end
