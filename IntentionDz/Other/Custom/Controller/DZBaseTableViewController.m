//
//  DZBaseTableViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/28.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseTableViewController.h"
#import "DZBaseTableViewCell.h"
#import "NHBaseTableHeaderFooterView.h"
#import <objc/runtime.h>
#import "MJExtension.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"
const char NHBaseTableVcNavRightItemHandleKey;
const char NHBaseTableVcNavLeftItemHandleKey;
@interface DZBaseTableViewController ()
@property (nonatomic, copy) DZTableVcCellSelectedHandle handle;
@property (nonatomic, weak) UIImageView *refreshImg;
@end

@implementation DZBaseTableViewController
@synthesize needCellSepLine = _needCellSepLine;
@synthesize sepLineColor = _sepLineColor;
@synthesize navItemTitle = _navItemTitle;
@synthesize navRightItem = _navRightItem;
@synthesize navLeftItem = _navLeftItem;
@synthesize hiddenStatusBar = _hiddenStatusBar;
@synthesize barStyle = _barStyle;
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
-(DZBaseTabelView*)tableView{
    if (!_tableView) {
        DZBaseTabelView *tab=[[DZBaseTabelView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _tableView=tab;
        tab.dataSource=self;
        tab.delegate=self;
        tab.backgroundColor=[UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        tab.separatorColor=kSeperatorColor;
    }
    return _tableView;
}

-(void)setNeedCellSepLine:(BOOL)needCellSepLine{
    _needCellSepLine=needCellSepLine;
    self.tableView.separatorStyle=needCellSepLine? UITableViewCellSeparatorStyleSingleLine:UITableViewCellSeparatorStyleNone;
}
-(void)setShowRefreshIcon:(BOOL)showRefreshIcon{
    _showRefreshIcon=showRefreshIcon;
    self.refreshImg.hidden=!showRefreshIcon;
}

-(UIImageView*)refreshImg{
    if (!_refreshImg) {
        UIImageView *refreshImg=[[UIImageView alloc]init];
        [self.view addSubview:refreshImg];
        _refreshImg=refreshImg;
        [self.view bringSubviewToFront:refreshImg];
        refreshImg.image=[UIImage imageNamed:@"refresh"];
        WeakSelf(weakSelf);
        [refreshImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.view).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.bottom.mas_equalTo(weakSelf.view).mas_equalTo(-20);
            refreshImg.layerCornerRadius=22;
            refreshImg.backgroundColor=kWhiteColor;
            [refreshImg setTapActionWithBlock:^{
                [self startAnimation];
                [weakSelf nh_beginRefresh];
            }];
        }];
    }
    return _refreshImg;
}

- (void)endRefreshIconAnimation;{
    [self.refreshImg.layer removeAnimationForKey:@"rotitationAnimation"];
}
-(void)nh_endRefresh{
    if (self.refreshType == DZBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == DZBaseTableVcRefreshTypeOnlyCanLoadMore) {
        [DZUtils endRefreshForScrollView:self.tableView];
    }
}
-(void)nh_beginRefresh{
    if (self.refreshType==DZBaseTableVcRefreshTypeNoneRefreshAndLoadMore||self.refreshType==DZBaseTableVcRefreshTypeOnlyCanRefresh) {
        [DZUtils beginPullRefreshForScrollView:self.tableView];
    }
}

-(void)startAnimation{
    CABasicAnimation *rotationAnimation;
    rotationAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue=[NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration=1.5;
    rotationAnimation.cumulative=YES;
    rotationAnimation.repeatDuration=MAXFLOAT;
    [self.refreshImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame=self.view.bounds;
    [self.view sendSubviewToBack:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }

}
#pragma mark - loading & alert
- (void)nh_showLoading {

}

- (void)nh_hiddenLoading {
   
}

- (void)nh_showTitle:(NSString *)title after:(NSTimeInterval)after {

}
-(void)dz_addEmptyPageWithText:(NSString *)text{
    
}

-(void)dz_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void (^)(NSString *))handle{
    [self dz_setUpNavItemTitle:itemTitle handle:handle leftFlag:NO];
}
-(void)dz_setUpNavRightItemTitle:(NSString *)item handle:(void (^)(NSString *))handle{
    [self dz_setUpNavItemTitle:item handle:handle leftFlag:YES];
}
- (void)dz_setUpNavItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *itemTitle))handle leftFlag:(BOOL)leftFlag{
    if (itemTitle.length==0||!handle) {
        if (itemTitle==nil) {
            itemTitle=@"";
        }else if ([itemTitle isKindOfClass:[NSNull class]]){
            itemTitle=@"";
        }
        if (leftFlag) {
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        }else{
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        }
    }else{
        if (leftFlag) {
//            objc_setAssociatedObject来把一个对象与另外一个对象进行关联。该函数需要四个参数：源对象，关键字，关联的对象和一个关联策略
            objc_setAssociatedObject(self, &NHBaseTableVcNavLeftItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(dz_navItemHandle:)];
        }else{
            objc_setAssociatedObject(self, &NHBaseTableVcNavRightItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
             self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(nh_navItemHandle:)];
        }
    }
    
}
-(void)nh_navItemHandle:(UIBarButtonItem*)item{
    void(^handle)(NSString*)=objc_getAssociatedObject(self, &NHBaseTableVcNavRightItemHandleKey);
    if (handle) {
        handle(item.title);
    }
}

-(void)dz_observeNotiWithNotName:(NSString *)notiName action:(SEL)action{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:action name:notiName object:nil];
}

-(void)nh_addRefresh{
    
}
-(void)nh_addLoadMore{
    
}

-(void)setRefreshType:(DZBaseTableVcRefreshType)refreshType{
    _refreshType=refreshType;
    switch (refreshType) {
        case DZBaseTableVcRefreshTypeNone:
            break;
        case DZBaseTableVcRefreshTypeOnlyCanRefresh:{
            [self nh_addRefresh];
        }break;
        case DZBaseTableVcRefreshTypeNoneRefreshAndLoadMore:{
            [self nh_addLoadMore];
        }break;
        case DZBaseTableVcRefreshTypeOnlyCanLoadMore:{
            [self nh_addRefresh];
            [self nh_addLoadMore];
            break;
        }break;
        default:
            break;
    }
}
/** 刷新数据*/
- (void)nh_reloadData {
    [self.tableView reloadData];
}
-(void)setNavItemTitle:(NSString *)navItemTitle{
    if ([navItemTitle isKindOfClass:[NSString class]]==NO) {
        return;
    }
    if ([navItemTitle isEqualToString:_navItemTitle]) {
        return;
    }
    _navItemTitle=navItemTitle.copy;
    self.navigationItem.title=navItemTitle;
}

-(void)setHiddenStatusBar:(BOOL)hiddenStatusBar{
    _hiddenStatusBar=hiddenStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark ---tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self respondsToSelector:@selector(nh_numberOfSections)]) {
        return [self nh_numberOfSections];
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(nh_numberOfRowsInSection:)]) {
        return [self nh_numberOfRowsInSection:section];
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(nh_headerAtSection:)]) {
        return [self nh_headerAtSection:section];
    }
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(nh_footerAtSection:)]) {
        return [self nh_footerAtSection:section];
    }
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(nh_cellAtIndexPath:)]) {
        return [self nh_cellAtIndexPath:indexPath];
    }
    DZBaseTableViewCell *cell=[DZBaseTableViewCell cellWithTableView:self.tableView];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DZBaseTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(nh_didSelectCellAtIndexPath:cell:)]) {
        [self nh_didSelectCellAtIndexPath:indexPath cell:cell];
    }
}
// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(nh_cellheightAtIndexPath:)]) {
        return [self nh_cellheightAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(nh_sectionHeaderHeightAtSection:)]) {
        return [self nh_sectionHeaderHeightAtSection:section];
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(nh_sectionFooterHeightAtSection:)]) {
        return [self nh_sectionFooterHeightAtSection:section];
    }
    return 0.01;
}

- (NSInteger)nh_numberOfSections { return 0; }

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section { return 0; }

- (UITableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath { return [DZBaseTableViewCell cellWithTableView:self.tableView]; }

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath { return 0; }

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DZBaseTableViewCell *)cell { }

- (UIView *)nh_headerAtSection:(NSInteger)section { return [NHBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView]; }

- (UIView *)nh_footerAtSection:(NSInteger)section { return [NHBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView]; }

- (CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section { return 0.01; }

- (CGFloat)nh_sectionFooterHeightAtSection:(NSInteger)section { return 0.01; }

- (UIEdgeInsets)nh_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath { return UIEdgeInsetsMake(0, 15, 0, 0); }

- (void)dealloc { [[NSNotificationCenter defaultCenter] removeObserver:self]; }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
