//
//  DZCustomLoadingAnimationView.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/28.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZCustomLoadingAnimationView.h"

@interface DZCustomLoadingAnimationView ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation DZCustomLoadingAnimationView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];;
    }
    return self;
}

-(void)showInView:(UIView *)view{
    if (view==nil) {
        view=[UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:self];
    self.frame=view.bounds;
    self.imageView.frame=CGRectMake(0, 0, 70, 100);
    self.imageView.center=self.center;
    [self.imageView startAnimating];
}
-(void)dissmiss{
    [self.imageArray removeAllObjects];
        [self.imageView stopAnimating];
    [self.imageView removeFromSuperview];
    [self removeFromSuperview];
}
- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *img=[[UIImageView alloc]init];
        [self addSubview:img];
        _imageView=img;
        for (int i=0; i<17; i++) {
            UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"refreshjoke_loading_%d",i]];
            [self.imageArray addObject:image];
        }
        self.imageView.animationDuration=1.0;
        self.imageView.animationRepeatCount=0;
        self.imageView.animationImages=self.imageArray;
    }
    return _imageView;
}
@end
