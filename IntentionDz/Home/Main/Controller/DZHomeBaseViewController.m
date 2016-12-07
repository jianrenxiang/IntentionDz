//
//  DZHomeBaseViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/18.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZHomeBaseViewController.h"
#import "DZBaseRequest.h"
#import "DZHomeListRequest.h"
#import "UIViewController+Loading.h"
#import "DZHomeServiceDataModel.h"
#import "DZHomeTopTipView.h"
#import "DZHomeTableViewCellFrame.h"
#import "DZHomeTableViewCell.h"
#import "MJPhoto.h"
#import "WMPlayer.h"
#import "MJPhotoBrowser.h"
#import "DZCustomAleartView.h"
#import "DZHomeDynamicRequest.h"
#import "DZDynamicDetailViewController.h"
#import "DZBaseImageView.h"
#import "NHHomeNeiHanShareView.h"
#import "DZBaseNavigationViewController.h"
#define kTipTopViewH 30
@interface DZHomeBaseViewController ()<DZHomeTableViewCellDelegate,WMPlayerDelegate>
@property(nonatomic,copy)NSString *url;
@property(nonatomic,strong)DZBaseRequest *request;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray *cellFrameArray;
@property (nonatomic, weak) DZBaseImageView *imageView;
@property(nonatomic,weak)DZHomeTopTipView *topTipView;
@property (nonatomic, assign) BOOL isSmallScreen;
/** 是否显示提示视图*/
@property (nonatomic, assign) BOOL showTopTipViewFlag;
@end

@implementation DZHomeBaseViewController{
     WMPlayer *wmPlayer;
}

- (NSMutableArray *)cellFrameArray {
    if (!_cellFrameArray) {
        _cellFrameArray = [NSMutableArray new];
    }
    return _cellFrameArray;
}

-(instancetype)initWithUrl:(NSString *)url{
    if ([super init]) {
        self.url=url;
    }
    return self;
}

-(instancetype)initWitnRequest:(DZBaseRequest *)request{
    if ([super init]) {
        self.request=request;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    不要分割线
    self.needCellSepLine=NO;
//    刷新头像
    self.showRefreshIcon=YES;
    self.refreshType=DZBaseTableVcRefreshTypeNoneRefreshAndLoadMore;
    [self showLoadingAnimation];
    if (self.url.length) {
        DZHomeListRequest *request=[DZHomeListRequest dz_request];
        request.dz_url=self.url;
        self.request=request;
        [self loadData];
    }else{
        [self loadData];
    }
}

-(void)nh_refresh{
    [super nh_refresh];
    [self loadData];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self releaseWMPlayer];
}
- (void)releaseWMPlayer {
    [wmPlayer pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}
//加载动画
-(void)loadData{
    if (self.request) {
        [self.request dz_sendRequestWithCompletion:^(id reponse, BOOL success, NSString *message) {
            if (success) {
                [self hideLoadingView];
                [self endRefreshIconAnimation];
                DZHomeServiceDataModel *model=[DZHomeServiceDataModel modelWithDictionary:reponse];
                if (model.tip.length&&_dataArray!=nil&&_cellFrameArray!=nil) {
                    self.topTipView.hidden=NO;
                    self.topTipView.tipText=model.tip;
                    self.showTopTipViewFlag=YES;
                }else{
                    self.topTipView.hidden=YES;
                    [self nh_endRefresh];
                }
                [self.cellFrameArray removeAllObjects];
                [self.dataArray removeAllObjects];
                for (int i=0; i<model.data.count; i++) {
                    NHHomeServiceDataElement *element=model.data[i];
               
                    if (element.group&& element.group.media_type < 5) {
                            [self.dataArray addObject:element];
                        DZHomeTableViewCellFrame *cellFrame=[[DZHomeTableViewCellFrame alloc]init];
                        cellFrame.model=element;
                        [self.cellFrameArray addObject:cellFrame];
                    }
                }
                [self nh_reloadData];
            }
        }];
    }else{
        return;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (wmPlayer.superview) {
        CGRect rectIntableView=[self.tableView rectForRowAtIndexPath:self.indexPath];
        CGRect rectInSuperView=[self.tableView convertRect:rectIntableView toView:[self.tableView superview]];
        if (rectInSuperView.origin.y<-self.imageView.frame.size.height||rectInSuperView.origin.y>kScreenHeight-kTopBarHeight-kTabBarHeight) {
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]&&self.isSmallScreen){
            self.isSmallScreen=YES;
        }else{
            [self releaseWMPlayer];
        }
    }else{
        if ([self.imageView.subviews containsObject:wmPlayer]) {
        }else{
            [self releaseWMPlayer];
       }
    }
  }
}

-(void)setShowTopTipViewFlag:(BOOL)showTopTipViewFlag{
    _showTopTipViewFlag=showTopTipViewFlag;
    [UIView animateWithDuration:0.4 animations:^{
        self.topTipView.frame=CGRectMake(0, 0, self.view.width, kTipTopViewH);
    }completion:^(BOOL finished) {
//        功能：延迟一段时间把一项任务提交到队列中执行，返回之后就不能取消
      /*  when 过了多久执行的时间间隔
        queue   提交到的队列
        block   执行的任务
       */
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
          [self nh_endRefresh];
          [UIView animateWithDuration:0.4 animations:^{
              self.topTipView.frame = CGRectMake(0, - kTipTopViewH, 0, kTipTopViewH);
          }];

      });
    }];
}

-(DZHomeTopTipView*)topTipView{
    if (!_topTipView) {
        DZHomeTopTipView *topTipView=[[DZHomeTopTipView alloc]initWithFrame:CGRectMake(0, -kTipTopViewH, kScreenWidth, kTipTopViewH)];
        [self.view addSubview:topTipView];
        _topTipView=topTipView;
    }
    return _topTipView;
}

-(NSInteger)nh_numberOfSections{
    return 1;
}

-(CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath{
    DZHomeTableViewCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
    return cellFrame.cellHeight;
}

-(DZBaseTableViewCell*)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    DZHomeTableViewCell *cell=[DZHomeTableViewCell cellWithTableView:self.tableView];
    DZHomeTableViewCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
    cell.cellFrame=cellFrame;
    cell.delegate=self;
    cell.isFromHomeController=YES;
    return cell;
}

-(NSInteger)nh_numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DZBaseTableViewCell *)cell {
    DZDynamicDetailViewController *controller = [[DZDynamicDetailViewController alloc] initWithCellFrame:self.cellFrameArray[indexPath.row]];
    [self pushVc:controller];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--cellDelegate
-(void)homeTableViewCell:(DZHomeTableViewCell *)cell didClickImage:(UIImageView *)imageView currentIndex:(NSInteger)currentIndex urls:(NSArray<NSURL *> *)urls{
    MJPhotoBrowser *photoBrower=[[MJPhotoBrowser alloc]init];
    NSMutableArray *phoneArray=[NSMutableArray new];
    for (NSURL *imageUrl in urls) {
        MJPhoto *photo=({
            MJPhoto *photo=[[MJPhoto alloc]init];
            photo.url=imageUrl;
            photo.srcImageView=imageView;
            photo;
        });
        [phoneArray addObject:photo];
    }
    photoBrower.photos=phoneArray;
    photoBrower.currentPhotoIndex=currentIndex;
    [photoBrower show];
}

-(void)homeTableViewCellDidClickClose:(DZHomeTableViewCell *)cell{
    DZCustomAleartView *alert=[[DZCustomAleartView alloc]initWithTitle:@"确认删除后，内涵段子将减少给您推荐类似的内容，您确认要删除吗？" cancle:@"取消" sure:@"确认删除"];
    [alert showInview:self.view.window];
    WeakSelf(weakSelf);
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    [alert setUpSureBlock:^BOOL{
        [weakSelf deleteDynamicAtIndexPath:indexPath];
        return YES;
    }];
    
}

-(void)homeTableViewCell:(DZHomeTableViewCell *)cell didClickImageVideoWithVideoUrl:(NSString *)videoUrl videoCover:(DZBaseImageView *)baseImageView{
    self.indexPath=[self.tableView indexPathForCell:cell];
    self.imageView=baseImageView;
    
    wmPlayer = [[WMPlayer alloc]initWithFrame:baseImageView.bounds];
    wmPlayer.delegate = self;
    wmPlayer.closeBtnStyle = CloseBtnStyleClose;
    wmPlayer.URLString = videoUrl;
    [baseImageView addSubview:wmPlayer];
    [wmPlayer play];
}

- (void)deleteDynamicAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.cellFrameArray removeObjectAtIndex:indexPath.row];
    [self.tableView nh_deleteSingleRowAtIndexPath:indexPath];
}
-(void)homeTableViewCell:(DZHomeTableViewCell *)cell didClickItemWithType:(DZHomeTableViewCellItemType)item{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    DZHomeTableViewCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
    WeakSelf(weakSelf);
    switch (item) {
        case DZHomeTableViewCellItemTypeLike: {
            [self requestActionWithActionname:@"digg" indexPath:indexPath];
        } break;
            
        case DZHomeTableViewCellItemTypeDontLike: {
            [self requestActionWithActionname:@"bury" indexPath:indexPath];
        } break;
        case DZHomeTableViewCellItemTypeComment: {
            // 跳转
            DZDynamicDetailViewController *controller = [[DZDynamicDetailViewController alloc] initWithCellFrame:cellFrame];
            [self pushVc:controller];
        } break;
        case DZHomeTableViewCellItemTypeShare: {
            NHHomeNeiHanShareView *share = [NHHomeNeiHanShareView shareViewWithType:NHHomeNeiHanShareViewTypeShowCopyAndCollect hasRepinFlag:cellFrame.model.group.user_repin];
            [share showInView:self.view];
            [share setUpItemClickHandle:^(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index, NHNeiHanShareType shareType) {
                [[NHNeiHanShareManager sharedManager] shareWithSharedType:shareType image:nil url:@"www.baidu.com" content:@"不错" controller:weakSelf];
            }];
            [share setUpBottomItemClickHandle:^(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index) {
                
                switch (index) {
                    case 0: {
                        NSString *shareUrl = cellFrame.model.group.share_url;
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        pasteboard.string = shareUrl;
                        [MBProgressHUD showSuccess:@"已复制" toView:self.view];
                    } break;
                        
                    case 1: {
                        [self requestActionWithActionname:cellFrame.model.group.user_repin ? @"unrepin" : @"repin" indexPath:indexPath];
                    } break;
                        
                    case 2: {
                        DZDynamicDetailViewController *controller = [[DZDynamicDetailViewController alloc] init];
                        DZBaseNavigationViewController *nav = [[DZBaseNavigationViewController alloc] initWithRootViewController:controller];
                        [self presentVc:nav];
                    } break;
                        
                    default:
                        break;
                }
            }];
            
        }
            break;
    
        default:
            break;
    }
}

-(void)requestActionWithActionname:(NSString *)actionname indexPath:(NSIndexPath *)indexPath{
    DZHomeTableViewCellFrame *cellFrame=[self.cellFrameArray objectAtIndex:indexPath.row];
    DZHomeDynamicRequest *request = [DZHomeDynamicRequest dz_request];
    request.group_id = cellFrame.model.group.ID;
    request.dz_url = kNHHomeDynamicLikeAPI;
    request.action = actionname;
    [request dz_sendRequestWithCompletion:^(id reponse, BOOL success, NSString *message) {
        if (success) {
            DZHomeTableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
            if ([actionname isEqualToString:@"digg"]) {
                if (cellFrame.model.group.user_digg) return ;
                cellFrame.model.group.user_digg = 1;
                cellFrame.model.group.digg_count += 1;
                [cell didDing];
            }else if ([actionname isEqualToString:@"bury"]) {
                if (cellFrame.model.group.user_bury) return ;
                cellFrame.model.group.user_bury = 1;
                cellFrame.model.group.bury_count += 1;
                [cell didBury];
            } else if ([actionname isEqualToString:@"repin"]) { // 收藏
                cellFrame.model.group.user_repin = 1;
            } else if ([actionname isEqualToString:@"unrepin"]) { // 取消收藏
                cellFrame.model.group.user_repin = 0;
            }

        }
    }];
}

-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    if (wmPlayer.isFullscreen) {
        wmPlayer.isFullscreen=NO;
        [self toCell];
    }else{
        [self toCell];
    }
}
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (fullScreenBtn.isSelected) {
        wmPlayer.isFullscreen=YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        if (self.isSmallScreen) {
            // 放widow上,小屏显示
            [self toSmallScreen];
        } else {
            [self toCell];
        }
    }
}
- (void)wmplayerFinishedPlay:(WMPlayer *)wmplayer {
    [self releaseWMPlayer];
}

- (void)toSmallScreen {
    // 放widow上
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.3f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = CGRectMake(kScreenWidth/2,kScreenHeight-kTabBarHeight-(kScreenWidth/2)*0.75, kScreenWidth/2, (kScreenWidth/2)*0.75);
        wmPlayer.playerLayer.frame = wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
            
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
        
    } completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        wmPlayer.fullScreenBtn.selected = NO;
        self.isSmallScreen = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmPlayer];
    }];
}
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    [wmPlayer removeFromSuperview];
    wmPlayer.transform=CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform=CGAffineTransformMakeRotation(-M_PI_2);
    }else if (interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, kScreenHeight,kScreenWidth);
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(kScreenWidth-40);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmPlayer).with.offset((-kScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
        
    }];
    
    [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer.topView).with.offset(45);
        make.right.equalTo(wmPlayer.topView).with.offset(-45);
        make.center.equalTo(wmPlayer.topView);
        make.top.equalTo(wmPlayer.topView).with.offset(0);
    }];
    
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)));
        make.height.equalTo(@30);
    }];
    
    [wmPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-37, -(kScreenWidth/2-37)));
    }];
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)+36));
        make.height.equalTo(@30);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    
    wmPlayer.fullScreenBtn.selected = YES;
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
}

-(BOOL)prefersStatusBarHidden{
    if (wmPlayer) {
        if (wmPlayer.isFullscreen) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

-(void)toCell{
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        wmPlayer.transform=CGAffineTransformIdentity;
        wmPlayer.frame=self.imageView.bounds;
        wmPlayer.playerLayer.frame=wmPlayer.bounds;
        [self.imageView addSubview:wmPlayer];
        [self.imageView bringSubviewToFront:wmPlayer];
        [wmPlayer.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.equalTo(@40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        self.isSmallScreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        
    }];
}

@end
