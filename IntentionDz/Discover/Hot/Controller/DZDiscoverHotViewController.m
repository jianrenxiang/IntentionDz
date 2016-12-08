//
//  DZDiscoverHotViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/8.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZDiscoverHotViewController.h"
#import "DZDiscoverHeaderView.h"
#import "DZDiscoverRequest.h"
#import "DZDiscoverModel.h"
#import "DZDiscoverTopicViewController.h"
#import "dzdiscoverTableViewCell.h"
@interface DZDiscoverHotViewController ()
/** 轮播图数据数组*/
@property (nonatomic, strong) NSMutableArray *bannerImgArray;
/** 头部视图*/
@property (nonatomic, strong) DZDiscoverHeaderView *headerView;
@end

@implementation DZDiscoverHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置子视图
    [self setUpViews];
    [self loadData];
}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    
    self.refreshType = DZBaseTableVcRefreshTypeNoneRefreshAndLoadMore;
}
// 请求数据
- (void)loadData {
    DZDiscoverRequest *request = [DZDiscoverRequest dz_request];
    request.dz_url = kNHDiscoverHotListAPI;
    [request dz_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            DZDiscoverModel *discoverModel = [DZDiscoverModel modelWithDictionary:response];
            
            self.bannerImgArray = discoverModel.rotate_banner.banners;
            
            if (self.bannerImgArray.count) {
                
                self.headerView.modelArray = self.bannerImgArray;
                WeakSelf(weakSelf);
                self.headerView.discoverHeaderViewGoToPageHandle = ^(DZDiscoverHeaderViewViewCell *cell, NHDiscoverRotate_bannerElement *elementModel) {
                    
                    NSMutableString *schema_url = elementModel.schema_url.mutableCopy;
                    if (schema_url.length > 4) {
                        [schema_url deleteCharactersInRange:NSMakeRange(0, 4)];
                    }
                    NSInteger categoryId = schema_url.integerValue;
                    DZDiscoverTopicViewController *topic = [[DZDiscoverTopicViewController alloc] initWithCatogoryId:categoryId];
                    topic.navigationItem.title = elementModel.banner_url.title;
                    [weakSelf pushVc:topic];
                };
            }
            self.dataArray = discoverModel.categories.category_list;
            [self.tableView reloadData];
        }
    }];
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (DZBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    DZDiscoverTableViewCell *cell = [DZDiscoverTableViewCell cellWithTableView:self.tableView];
    cell.elementModel=self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DZBaseTableViewCell *)cell {
//    NHDiscoverCategoryElement *elementModel = self.dataArray[indexPath.row];
//    NHDiscoverTopicViewController *topic = [[NHDiscoverTopicViewController alloc] initWithCategoryElement:elementModel];
//    //    [[NHDiscoverTopicViewController alloc] initWithCatogoryId:elementModel.ID];
//    [self pushVc:topic];
}

- (NSMutableArray *)bannerImgArray {
    if (!_bannerImgArray) {
        _bannerImgArray = [NSMutableArray new];
    }
    return _bannerImgArray;
}
- (DZDiscoverHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[DZDiscoverHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
        self.tableView.tableHeaderView = _headerView;
    }
    return _headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
