//
//  DZCustomSlideViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZCustomSlideViewController.h"

@interface DZCustomSlideViewController ()
@property(nonatomic,strong)UIScrollView *scrollerView;
@end

@implementation DZCustomSlideViewController

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollerView.frame=self.view.bounds;
    self.scrollerView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*[self childViewControllerCount], self.scrollerView.height);
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex=selectIndex;
    [self.scrollerView setContentOffset:CGPointMake(kScreenHeight*selectIndex, 0) animated:YES];
}

-(NSInteger)childViewControllerCount{
    return 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
