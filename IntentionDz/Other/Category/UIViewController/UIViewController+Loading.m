//
//  UIViewController+Loading.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/29.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "UIViewController+Loading.h"
#import <objc/runtime.h>
const static char loadingViewKey;
@interface UIViewControllerLoadingView: UIView
@property(nonatomic,weak)UILabel *label;
@property(nonatomic,weak)UIActivityIndicatorView *indView;
@end

@implementation UIViewControllerLoadingView

-(UILabel*)label{
    if (!_label) {
        UILabel *label=[[UILabel alloc]init];
        [self addSubview:label];
        _label=label;
        label.font=kFont(13);
        label.textColor=kTextColor;
    }
    return _label;
}

-(UIActivityIndicatorView*)indView{
    if (!_indView) {
        UIActivityIndicatorView *ind=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:ind];
        _indView=ind;
    }
    return _indView;
}

-(void)startAnimating{
    [self.indView startAnimating];
    [super layoutSubviews];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.label.frame=CGRectMake(self.width/2.0-30, self.height/2.0-40, 80, 40);
    self.indView.frame=CGRectMake(self.width/2.0-70, self.label.y, 40, 40);
}
@end

@implementation UIViewController (Loading)
-(void)showLoadingView{
    [self showLoadingViewWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
}

-(UIView*)loadingView{
//    关联对象
    return objc_getAssociatedObject(self, &loadingViewKey);
}

- (void)setLoadingView:(UIView *)loadingView {
    objc_setAssociatedObject(self, &loadingViewKey, loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)showLoadingViewWithFrame:(CGRect)frame{
    if (!self.loadingView) {
        UIViewControllerLoadingView *loadingViews=[[UIViewControllerLoadingView alloc]init];
        self.loadingView=loadingViews;
        loadingViews.frame=frame;
        [self.view addSubview:self.loadingView];
        loadingViews.center=self.view.center;
        loadingViews.centerX=self.view.centerY-50;
        [loadingViews startAnimating];
    }
}
-(void)hideLoadingView{
    if (self.loadingView) {
        [self.loadingView removeFromSuperview];
    }
}
@end
