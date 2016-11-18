//
//  DZHomeViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZHomeViewController.h"
#import "DZCustomSementView.h"
#import "NHServiceListModel.h"
#import "DZHomeHeaderOptionView.h"
#import "DZCustomSlideViewController.h"
#import "DZHomeBaseViewController.h"
#import "DZCustomWebViewController.h"
@interface DZHomeViewController ()<DZCustomSlideControllerDataSoure,DZCustomSlideControllerDelegate>
@property(nonatomic,weak)DZHomeHeaderOptionView *optionalView;
@property(nonatomic,weak)DZCustomSlideViewController *slideViewController;
@property(nonatomic,strong)NSMutableArray *controllers;
@property(nonatomic,strong)NSMutableArray *titles;
@property(nonatomic,strong)NSMutableArray *urls;
@end

@implementation DZHomeViewController
//懒加载
-(DZHomeHeaderOptionView*)optionalView{
    if (!_optionalView) {
        DZHomeHeaderOptionView *optional=[[DZHomeHeaderOptionView alloc]init];
        optional.frame=CGRectMake(0, 0, kScreenWidth, 40);
        [self.view addSubview:optional];
        _optionalView=optional;
        optional.backgroundColor=kWhiteColor;
    }
    return _optionalView;
}

-(NSMutableArray*)controllers{
    if (!_controllers) {
        _controllers=[NSMutableArray array];
    }
    return _controllers;
}

-(NSMutableArray*)titles{
    if (!_titles) {
        _titles=[[NSMutableArray alloc]init];
    }
    return _titles;
}

-(NSMutableArray*)urls{
    if (!_urls) {
        _urls=[[NSMutableArray alloc]init];
    }
    return _urls;
}
-(DZCustomSlideViewController*)slideViewController{
    if (!_slideViewController) {
    DZCustomSlideViewController *slide=[[DZCustomSlideViewController alloc]init];
/**
- (void)addChildViewController:(UIViewController *)childController
 
 - (void) removeFromParentViewController
 交换控制器之前的顺序
 - (void)transitionFromViewController：：：：：：
 当一个视图控制器从视图控制器容器中被添加或者被删除之前，该方法被调用，parent是父视图控制器
 - (void)willMoveToParentViewController:(UIViewController *)parent
 
 - (void)didMoveToParentViewController:(UIViewController *)parent
 上面四个方法可以控制控制器的耦合性，
 让控制器上可以有多个控制器。
 */
#pragma mark--注意控制器的添加
    [slide willMoveToParentViewController:self];
    [self addChildViewController:slide];
    [self.view addSubview:slide.view];
    slide.view.frame=CGRectMake(0, self.optionalView.bottom, kScreenWidth, kScreenHeight-self.optionalView.height-kTopBarHeight-kTabBarHeight);
        slide.delegate=self;
        slide.datasoure=self;
        _slideViewController=slide;
  }
    return _slideViewController;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setUpItems];
}

-(void)setModels:(NSArray<DZServiceListRequest *> *)models{
    if (models.count==0) {
        return;
    }
    for (NHServiceListModel *model in models) {
        if ([model.name isKindOfClass:[NSString class]]) {
            [self.titles addObject:model.name];
        }
        if ([model.url isKindOfClass:[NSString class]]) {
            [self.urls addObject:model.url];
        }
    }
 
    [self setUpView];
}

-(void)setUpView{
    if (self.titles.count==0) {
        return;
    }
    if (self.titles.count!=self.urls.count) {
        return;
    }
    for (int i=0; i<self.urls.count; i++) {
        NSString *url=self.urls[i];
        NSString *title=self.titles[i];
        if ([title isEqual:@"游戏"]) {
            NSLog(@"网页加载中....");
        }else if ([title isEqualToString:@"精华"]){
            DZCustomWebViewController *webView=[[DZCustomWebViewController alloc]init];
            [self.controllers addObject:webView];
        }else{
            DZHomeBaseViewController *homeBase=[[DZHomeBaseViewController alloc]init];
            [self.controllers addObject:homeBase];
        }
    }
    if ([self.titles containsObject:@"精华"]) {
        [self.titles removeObject:@"精华"];
    }
    WeakSelf(weakSelf);
    self.optionalView.titles=self.titles.copy;
    self.optionalView.homeHeaderOpetionalViewItemClickHandle=^(DZHomeHeaderOptionView *optionView,NSString *title,NSInteger currentIndex){
        weakSelf.slideViewController.selectIndex=currentIndex;
    };
    [self.slideViewController reloadDate];
}


-(void)setUpItems{
    WeakSelf(weakSelf);
    DZCustomSementView *segment=[[DZCustomSementView alloc]initWithTitles:@[@"精选",@"关注"]];
    self.navigationItem.titleView=segment;
    segment.frame=CGRectMake(0, 0, 130, 35);
    [segment clickDefault];
    segment.DZCustomSegmentViewBtnClickHandle=^(DZCustomSementView *semg,NSString *title,NSInteger currentIndex){
        BOOL isFeatured=(currentIndex==0);
        
        
    };
    
    
}
#pragma mark--
-(NSInteger)numberofChildViewControllerInSlideViewController:(DZCustomSlideViewController *)slideViewController{
    return self.titles.count;
}

-(UIViewController*)slideViewController:(DZCustomSlideViewController *)slideViewController viewControllerAtIndex:(NSInteger)index{
    return self.controllers[index];
}

-(void)customSlideViewController:(DZCustomSlideViewController *)slideViewController slideOffset:(CGPoint)slideOffset{
    self.optionalView.contentOffset=slideOffset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
