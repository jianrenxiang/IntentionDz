//
//  DZBaseViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseViewController.h"
#import "DZCustomLoadingAnimationView.h"
@interface DZBaseViewController ()
@property (nonatomic, weak) DZCustomLoadingAnimationView *animationView;
@end

@implementation DZBaseViewController

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.animationView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
}

-(void)showLoadingAnimation{
    DZCustomLoadingAnimationView *loadAnimation=[[DZCustomLoadingAnimationView alloc]init];
    [loadAnimation showInView:self.view];
    _animationView=loadAnimation;
    [self.view bringSubviewToFront:loadAnimation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
