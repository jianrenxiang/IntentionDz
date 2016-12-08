//
//  DZDiscoverViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZDiscoverViewController.h"
#import "DZCustomSementView.h"
#import "DZDiscoverSearchViewController.h"
#import "DZDiscoverNearByViewController.h"
#import "DZDiscoverSubScribeViewController.h"
#import "DZDiscoverHotViewController.h"
@interface DZDiscoverViewController ()
@property (nonatomic, strong) NSMutableArray *bannerImgArray;
/** 热吧*/
@property (nonatomic, strong) DZDiscoverHotViewController *hotController;
/** 订阅*/
@property (nonatomic, strong) DZDiscoverSubScribeViewController *subScibeController;
@end

@implementation DZDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setUpItems];
}
// 设置导航栏
- (void)setUpItems {
    DZCustomSementView *segment=[[DZCustomSementView alloc]initWithTitles:@[@"热吧",@"订阅"]];
    self.navigationItem.titleView=segment;
    segment.frame=CGRectMake(0, 0, 130, 35);
    WeakSelf(weakSelf);
    segment.DZCustomSegmentViewBtnClickHandle=^(DZCustomSementView *segment,NSString *title,NSInteger currentIndex){
        [weakSelf changeChildVcWithCurrentIndex:currentIndex];
    };
    [segment clickDefault];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"foundsearch"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nearbypeople"] style:UIBarButtonItemStylePlain target:self action:@selector(nearByItemClick)];
}
// 搜索
- (void)searchItemClick {
    DZDiscoverSearchViewController *searchController = [[DZDiscoverSearchViewController alloc] init];
    [self pushVc:searchController];
}

// 附近
- (void)nearByItemClick {
    DZDiscoverNearByViewController *nearByController = [[DZDiscoverNearByViewController alloc] init];
    [self pushVc:nearByController];
}
- (void)changeChildVcWithCurrentIndex:(NSInteger)currentIndex{
    BOOL isHot = (currentIndex == 0);
    
    if (isHot) { // 热门
        [self addChildVc:self.hotController];
        [self removeChildVc:self.subScibeController];
    } else { // 订阅
        [self addChildVc:self.subScibeController];
        [self removeChildVc:self.hotController];
    }
}
- (DZDiscoverSubScribeViewController *)subScibeController {
    if (!_subScibeController) {
        _subScibeController = [[DZDiscoverSubScribeViewController alloc] init];
        [self addChildVc:_subScibeController];
    }
    return _subScibeController;
}

- (DZDiscoverHotViewController *)hotController {
    if (!_hotController) {
        _hotController = [[DZDiscoverHotViewController alloc] init];
        [self addChildVc:_hotController];
    }
    return _hotController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
