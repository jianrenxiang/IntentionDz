//
//  DZDynamicDetailViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/1.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZDynamicDetailViewController.h"
#import "DZHomeTableViewCellFrame.h"
#import "DZDynamicDetailRequest.h"
#import "DZHomeServiceDataModel.h"
#import "DZDynamicDetailCommentCellFrame.h"
#import "DZBaseImageView.h"
#import "DZHomeTableViewCell.h"
#import "DZDynamicDetailCommentTableViewCell.h"

@interface DZDynamicDetailViewController ()<DZHomeTableViewCellDelegate,NHDynamicDetailCommentTableViewCellDelegate>
@property (nonatomic, strong) DZHomeTableViewCellFrame *cellFrame;
@property (nonatomic, strong) DZDynamicDetailCommentCellFrame *searchCellFrame;
@property (nonatomic, strong) NSMutableArray *commentCellFrameArray;
@property (nonatomic, strong) NSMutableArray *topCommentCellFrameArray;
@property (nonatomic, strong) NSMutableArray *topDataArray;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) DZBaseImageView *imageView;
@property (nonatomic, assign) BOOL isSmallScreen;
@end


@implementation DZDynamicDetailViewController

- (NSMutableArray *)commentCellFrameArray {
    if (!_commentCellFrameArray) {
        _commentCellFrameArray = [NSMutableArray new];
    }
    return _commentCellFrameArray;
}

- (NSMutableArray *)topDataArray {
    if (!_topDataArray) {
        _topDataArray = [NSMutableArray new];
    }
    return _topDataArray;
}

- (NSMutableArray *)topCommentCellFrameArray {
    if (!_topCommentCellFrameArray) {
        _topCommentCellFrameArray = [NSMutableArray new];
    }
    return _topCommentCellFrameArray;
}

- (instancetype)initWithCellFrame:(DZHomeTableViewCellFrame *)cellFrame {
    if (self = [super init]) {
        self.cellFrame = cellFrame;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    设置导航栏
    [self setUpItems];
//    设置子视图
    [self setUpViews];
//    请求数据
    [self loadData];
}

-(void)loadData{
    if (self.cellFrame) {
        DZHomeTableViewCellFrame *cellFrame=[[DZHomeTableViewCellFrame alloc]init];
        [cellFrame setModel:self.cellFrame.model isDetail:YES];
        self.cellFrame=cellFrame;
        [self nh_reloadData];
    }
    
    DZDynamicDetailRequest *request=[DZDynamicDetailRequest dz_request];
    request.dz_url = kNHHomeDynamicCommentListAPI;
    if (self.cellFrame) {
        request.group_id =self.cellFrame.model.group.ID;
    } else {
//        request.group_id = self.searchCellFrame.group.ID;
    }
    request.sort = @"hot";
    request.offset = 0;
    [request dz_sendRequestWithCompletion:^(id reponse, BOOL success, NSString *message) {
        if (success) {
            if ([reponse isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary *)reponse;
//                最近评论
                if ([dict.allKeys containsObject:@"recent_comments"]) {
                    self.dataArray = [NHHomeServiceDataElementComment modelArrayWithDictArray:reponse[@"recent_comments"]];
                    for (NHHomeServiceDataElementComment *comment in self.dataArray) {
                        DZDynamicDetailCommentCellFrame *cellFrame = [[DZDynamicDetailCommentCellFrame alloc] init];
                        cellFrame.commentModel = comment;
                        [self.commentCellFrameArray addObject:cellFrame];
                    }
                }
                // 热门评论
                if ([dict.allKeys containsObject:@"top_comments"]) {
                    self.topDataArray = [NHHomeServiceDataElementComment modelArrayWithDictArray:reponse[@"top_comments"]];
                    for (NHHomeServiceDataElementComment *comment in self.topDataArray) {
                        DZDynamicDetailCommentCellFrame *cellFrame = [[DZDynamicDetailCommentCellFrame alloc] init];
                        cellFrame.commentModel = comment;
                        [self.topCommentCellFrameArray addObject:cellFrame];
                    }
            }
        }
            [self nh_reloadData];
        }
    }];
}


-(NSInteger)nh_numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (self.topDataArray.count) {
        if (section == 1) {
            return self.topDataArray.count;
        } else if (section == 2) {
            return self.dataArray.count;
        }
    } else {
        if (section == 1) {
            return self.dataArray.count;
        }
    }
    return 0;
}
-(NSInteger)nh_numberOfSections{
    if (self.topDataArray.count) {
        return 3;
    }
    return 2;
}

-(DZBaseTableViewCell*)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        // 1. 创建cell
         DZHomeTableViewCell *cell = [DZHomeTableViewCell cellWithTableView:self.tableView];
        
        // 2. 设置数据
//        [cell setCellFrame:self.cellFrame isDetail:YES];
        cell.delegate = self;
        cell.backgroundColor=[UIColor redColor];
        // 3. 返回cell
        return cell;
    }
    DZDynamicDetailCommentTableViewCell *cell=[DZDynamicDetailCommentTableViewCell cellWithTableView:self.tableView];
    cell.delegate=self;
    cell.backgroundColor=[UIColor redColor];
    return cell;
}

-(CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.cellFrame.cellHeight;
    }
    if (self.topDataArray.count) {
        if (indexPath.section == 1) {
            DZDynamicDetailCommentCellFrame *cellFrame = self.topCommentCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        } else if (indexPath.section == 2) {
            DZDynamicDetailCommentCellFrame *cellFrame = self.commentCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        }
    } else {
        if (indexPath.section == 1) {
            DZDynamicDetailCommentCellFrame *cellFrame = self.commentCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        }
    }
    return 0;
}
- (CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 40;
}
-(void)setUpItems{
    self.title=@"详情";
    WeakSelf(weakSelf);
    [self dz_setUpNavLeftItemTitle:@"举报" handle:^(NSString *rightItemTitle) {
    }];
}
-(void)setUpViews{
    self.needCellSepLine=YES;
    self.sepLineColor=kSeperatorColor;
}

@end
