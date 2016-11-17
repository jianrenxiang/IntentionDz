//
//  DZHomeHeaderOptionView.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/16.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZHomeHeaderOptionView.h"
#import "NHHomeHeaderOptionViewItemView.h"
@interface DZHomeHeaderOptionView()<UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)CALayer *lineLayer;
@property(nonatomic,assign)NSInteger currentIndex;

@end


@implementation DZHomeHeaderOptionView


-(CALayer*)lineLayer{
    if (!_lineLayer) {
        CALayer *layer=[CALayer layer];
        [self.scrollView.layer addSublayer:layer];
        layer.backgroundColor=kSeperatorColor.CGColor;
        _lineLayer=layer;
    }
    return _lineLayer;
}

-(UIScrollView*)scrollView{
    if (!_scrollView) {
        UIScrollView *sc=[[UIScrollView alloc]init];
        sc.delegate=self;
        [self addSubview:sc];
        _scrollView=sc;
        sc.backgroundColor=[UIColor clearColor];
        sc.showsHorizontalScrollIndicator=NO;
        sc.showsVerticalScrollIndicator=NO;
    }
    return _scrollView;
}

-(void)setTitles:(NSArray<NSString *> *)titles{
    _titles=titles;
    if (titles.count) {
        for (int i=0; i<titles.count; i++) {
            NHHomeHeaderOptionViewItemView *item=[[NHHomeHeaderOptionViewItemView alloc]init];
            [self.scrollView addSubview:item];
            item.tag=i+1;
            item.text=titles[i];
            item.textAlignment=NSTextAlignmentCenter;
            item.userInteractionEnabled=YES;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapGest:)]];
        }
    }
    if (self.titles.count) {
        self.scrollView.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - kLineHeight);
        self.scrollView.contentSize=CGSizeMake(self.titles.count*60, self.scrollView.height-kLineHeight);
        CGFloat btnW=self.scrollView.contentSize.width/self.titles.count;
        for (int i=0; i<self.titles.count; i++) {
            NHHomeHeaderOptionViewItemView *item=(NHHomeHeaderOptionViewItemView*)[self.scrollView viewWithTag:i+1];
            item.frame=CGRectMake(btnW*i, 0, btnW, self.scrollView.height);
        }
    }
    
}

-(void)setContentOffset:(CGPoint)contentOffset{
    _contentOffset=contentOffset;
    CGFloat offsetX=contentOffset.x;
    NSInteger index=offsetX/kScreenWidth;
    NHHomeHeaderOptionViewItemView *leftItem=(NHHomeHeaderOptionViewItemView*)[self.scrollView viewWithTag:index+1];
    NHHomeHeaderOptionViewItemView *rightItem=(NHHomeHeaderOptionViewItemView*)[self.scrollView viewWithTag:index+2];
    
    CGFloat rightPageLeftDelta=offsetX-index*kScreenWidth;
    CGFloat progress=rightPageLeftDelta/kScreenWidth;
}

//item走的回调方法

-(void)itemTapGest:(UITapGestureRecognizer*)tapGest{
    NSLog(@"item被点击一次");
    NHHomeHeaderOptionViewItemView *item=(NHHomeHeaderOptionViewItemView*)tapGest.view;
    if (item) {
        if (self.homeHeaderOpetionalViewItemClickHandle) {
            self.homeHeaderOpetionalViewItemClickHandle(self,item.text,item.tag-1);
        }
        self.currentIndex=item.tag-1;
    }
}

@end
