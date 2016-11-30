//
//  DZBaseViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseViewController.h"
#import "DZCustomLoadingAnimationView.h"
#import "NSNotificationCenter+Addition.h"
#import "DZCommonConstant.h"
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
    self.edgesForExtendedLayout=UIRectEdgeAll;
    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    [NSNotificationCenter addObserver:self action:@selector(requestSuccessNotification) name:kDZRequestSuccessNotification];
    
}

-(void)requestSuccessNotification{
    [self hideLoadingAnimation];
}


-(void)showLoadingAnimation{
    DZCustomLoadingAnimationView *loadAnimation=[[DZCustomLoadingAnimationView alloc]init];
    [loadAnimation showInView:self.view];
    _animationView=loadAnimation;
    [self.view bringSubviewToFront:loadAnimation];
}
- (void)hideLoadingAnimation {
    [_animationView dissmiss];
    _animationView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
