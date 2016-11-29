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
#define kTipTopViewH 30
@interface DZHomeBaseViewController ()
@property(nonatomic,copy)NSString *url;
@property(nonatomic,strong)DZBaseRequest *request;
@property (nonatomic, strong) NSMutableArray *cellFrameArray;
@property(nonatomic,weak)DZHomeTopTipView *topTipView;
/** 是否显示提示视图*/
@property (nonatomic, assign) BOOL showTopTipViewFlag;
@end

@implementation DZHomeBaseViewController

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
        
    }
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
               
                    if (element.group) {
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

-(DZBaseTableViewCell*)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    DZHomeTableViewCell *cell=[DZHomeTableViewCell cellWithTableView:self.tableView];
    DZHomeTableViewCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
    return cell;
}

-(NSInteger)nh_numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
