//
//  DZCustomSlideViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZCustomSlideViewController.h"

@interface DZCustomSlideViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,strong)NSMutableDictionary *displayVcs;
@property(nonatomic,strong)NSMutableDictionary *memoryCache;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,weak)UIViewController *currentViewController;
@end

@implementation DZCustomSlideViewController

-(NSMutableDictionary*)memoryCache{
    if (!_memoryCache) {
        _memoryCache=[[NSMutableDictionary alloc]init];
    }
    return _memoryCache;
}

-(NSMutableDictionary*)displayVcs{
    if (!_displayVcs) {
        _displayVcs=[[NSMutableDictionary alloc]init];
    }
    return _displayVcs;
}


-(UIScrollView*)scrollerView{
    if (!_scrollerView) {
        UIScrollView *scroll=[[UIScrollView alloc]init];
        [self.view addSubview:scroll];
        _scrollerView=scroll;
        scroll.delegate=self;
        scroll.showsHorizontalScrollIndicator=NO;
        scroll.showsVerticalScrollIndicator=NO;
        scroll.pagingEnabled=NO;
        scroll.bounces=NO;
    }
    return _scrollerView;
}



-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollerView.frame=self.view.bounds;
    self.scrollerView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*[self childViewControllerCount], self.scrollerView.height);
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex=selectIndex;
    [self.scrollerView setContentOffset:CGPointMake(kScreenWidth*selectIndex, 0) animated:YES];
}

-(void)reloadDate{
    [self.memoryCache removeAllObjects];
    [self.displayVcs removeAllObjects];
    
    for (NSInteger index=0; index<self.childViewControllers.count; index++) {
        UIViewController *viewController=self.childViewControllers[index];
        [viewController.view removeFromSuperview];
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
    }
    self.scrollerView.frame=self.view.bounds;
    self.scrollerView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*[self childViewControllerCount], self.scrollerView.height);
    [self scrollViewDidScroll:self.scrollerView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage=scrollView.contentOffset.x/self.view.width;
    NSInteger start=currentPage==0?currentPage:(currentPage);
    NSInteger end=(currentPage==[self childViewControllerCount]-1)?currentPage:(currentPage);
    for (NSInteger index=start; index<=end; index++) {
        UIViewController *viewcontroller=[self.displayVcs objectForKey:@(index)];
        if (viewcontroller==nil) {
//            获取当前控制器
            [self initializedViewController:index];
        }
    }
    for (NSInteger index=0; index<=start-1; index++) {
        UIViewController *viewController=[self.displayVcs objectForKey:@(index)];
        [self removeChildViewController:viewController atIndex:index];
    }
    for (NSInteger index=end+1; index<=[self childViewControllerCount]-1; index++) {
        UIViewController *viewController=[self.displayVcs objectForKey:@(index)];
        [self removeChildViewController:viewController atIndex:index];
    }
    if ([self.delegate respondsToSelector:@selector(customSlideViewController:slideOffset:)]) {
        [self.delegate customSlideViewController:self slideOffset:scrollView.contentOffset];
    }
}

-(void)removeChildViewController:(UIViewController*)childController atIndex:(NSInteger)index{
    if (childController==nil) {
        return;
    }
    [childController.view removeFromSuperview];
    [childController willMoveToParentViewController:nil];
    [childController removeFromParentViewController];
    [self.displayVcs removeObjectForKey:@(index)];
    if (![self.memoryCache objectForKey:@(index)]) {
        [self.memoryCache setObject:childController forKey:@(index)];
    }
    
}

-(void)addChildViewController:(UIViewController *)childController atIndex:(NSInteger)index{
    if ([self.childViewControllers containsObject:childController]) {
        return;
    }
    [self addChildViewController:childController];
    [self.displayVcs setObject:childController forKey:@(index)];
    [childController willMoveToParentViewController:self];
    [self.scrollerView addSubview:childController.view];
    childController.view.frame=CGRectMake(index*kScreenWidth, 0, kScreenWidth, kScreenHeight);
}

-(void)initializedViewController:(NSInteger)index;{
    UIViewController *viewController=[self.memoryCache objectForKey:@(index)];
    if (viewController==nil) {
        if ([self.datasoure respondsToSelector:@selector(slideViewController:viewControllerAtIndex:)]) {
            UIViewController *viewcontroller=[self.datasoure slideViewController:self viewControllerAtIndex:index];
            [self addChildViewController:viewcontroller atIndex:index];
        }
    }else{
        [self addChildViewController:viewController atIndex:index];
    }
    
}

-(NSInteger)childViewControllerCount{
    if ([self.datasoure respondsToSelector:@selector(numberofChildViewControllerInSlideViewController:)]) {
        return [self.datasoure numberofChildViewControllerInSlideViewController:self];
    }
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
