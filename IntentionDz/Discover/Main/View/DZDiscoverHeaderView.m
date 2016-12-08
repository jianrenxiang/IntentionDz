//
//  DZDiscoverHeaderView.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/8.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZDiscoverHeaderView.h"
#import "NHDiscoverHeaderPageControl.h"
#import "DZDiscoverHeaderViewViewCell.h"
#import "DZDiscoverModel.h"
#define kCellIdentifier @"news"
#define kMaxSections 200
#define kTimeInterval 5.0f

@interface DZDiscoverHeaderView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) NHDiscoverHeaderPageControl *pageControl;
@end

@implementation DZDiscoverHeaderView{
    UIView *_lineView;
}
-(NHDiscoverHeaderPageControl*)pageControl{
    if (!_pageControl) {
        NHDiscoverHeaderPageControl *pageControl=[NHDiscoverHeaderPageControl pageControl];
        [self addSubview:pageControl];
        pageControl.frame=CGRectMake((kScreenWidth-100)/2, self.frame.size.height-20, 100, 20);
        pageControl.selectedItemColor=[UIColor redColor];
        pageControl.normalItemColor=kOrangeColor;
        _pageControl=pageControl;
        
    }
    return _pageControl;
}
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) collectionViewLayout:flowLayout];
        [self addSubview:collectionView];
        collectionView.showsHorizontalScrollIndicator=NO;
        collectionView.delegate=self;
        collectionView.dataSource=self;
        collectionView.pagingEnabled=YES;
        collectionView.backgroundColor=[UIColor clearColor];
        _collectionView=collectionView;
    }
    return _collectionView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame=self.bounds;
    _lineView.frame=CGRectMake(0, self.frame.size.height-0.5f, self.frame.size.width, 0.5);
    [self bringSubviewToFront:self.pageControl];
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    _lineView = [[UIView alloc] init];
    [self addSubview:_lineView];
    _lineView.backgroundColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f];
}

-(void)setModelArray:(NSArray<NHDiscoverRotate_bannerElement *> *)modelArray{
    _modelArray=modelArray;
    NSMutableArray *tmp=[NSMutableArray arrayWithArray:_modelArray];
    [tmp addObjectsFromArray:modelArray];
    _modelArray=tmp.copy;
    if (modelArray.count == 0) {
        return ;
    }
    self.pageControl.numberOfItems = _modelArray.count;
    [self addTimer];
    [self.collectionView registerClass:[DZDiscoverHeaderViewViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:kMaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self bringSubviewToFront:self.pageControl];
    [self.collectionView reloadData];
}
/*初始化UICollectionView，为什么将kNumberofSection定义为100？ 因为防止用户疯狂的滑动图片看下一张，如果kNumberofSection定义的很小的话，有可能后面就没有图片了。但你有可能有疑问？就算定义为100，也有可能过很长时间后，后面也没有图片了，这个细节操作，我们可以在定时器中处理。
 */
-(void)addTimer{
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer=timer;
}
-(void)removeTimer{
    [self.timer invalidate];
    self.timer=nil;
}

-(NSIndexPath*)resetIndexPath{
    NSIndexPath *cureetIndexPath=[[self.collectionView indexPathsForVisibleItems]lastObject];
    NSIndexPath *currentIndexPathReset=[NSIndexPath indexPathForItem:cureetIndexPath.item inSection:kMaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

-(void)nextPage{
    NSIndexPath *currentIndexPath=[self resetIndexPath];
    NSInteger nextItem=currentIndexPath.item+1;
    NSInteger nextSection=currentIndexPath.section;
    if (nextItem==self.modelArray.count) {
        nextItem=0 ;
        nextSection++;
    }
    NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kMaxSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 初始化
    DZDiscoverHeaderViewViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    // 2. 设置数据模型和索引
    NHDiscoverRotate_bannerElement *element = self.modelArray[indexPath.row];
    NHDiscoverRotate_bannerElementBanner_url_URL *urlModel =  element.banner_url.url_list.firstObject;
    cell.url = urlModel.url;
    cell.title = element.banner_url.title;
    // 3. 返回cell
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

#pragma mark  - UICollectionViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.modelArray.count;
    self.pageControl.currentIndex = page;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DZDiscoverHeaderViewViewCell *cell = (DZDiscoverHeaderViewViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NHDiscoverRotate_bannerElement *element = self.modelArray[indexPath.row];
    
    if (self.discoverHeaderViewGoToPageHandle) {
        self.discoverHeaderViewGoToPageHandle(cell, element);
    }
    
}

@end
