//
//  DZHomeAttentionViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/7.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZHomeAttentionViewController.h"
#import "DZHomeAttentionListRequest.h"
#import "DZHomeAttentionRequest.h"
#import "DZHomeBaseViewController.h"
#import "DZHomeAttentionEmptyView.h"
#import "DZHomeAttentionListViewController.h"
@interface DZHomeAttentionViewController ()
/** 没有关注的时候显示的视图*/
@property (nonatomic, weak) DZHomeAttentionEmptyView *emptyView;
@end

@implementation DZHomeAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DZHomeAttentionRequest *request=[DZHomeAttentionRequest dz_request];
    request.dz_url=kNHHomeAttentionDynamicListAPI;
    DZHomeBaseViewController *controller=[[DZHomeBaseViewController alloc]initWitnRequest:request];
    [self addChildVc:controller];
    WeakSelf(weakSelf);
    controller.hoemBaseControllerFinishRequestDataHandle=^(NSInteger dataCount){
        weakSelf.emptyView.hidden=dataCount>0;
    };
}
- (DZHomeAttentionEmptyView *)emptyView {
    if (!_emptyView) {
        DZHomeAttentionEmptyView *empty = [[DZHomeAttentionEmptyView  alloc] init];
        [self.view addSubview:empty];
        _emptyView = empty;
        // 点我找朋友
        WeakSelf(weakSelf);
        empty.homeAttentionEmptyViewFindFriendHandle = ^() {
            [weakSelf findFriendAction];
        };
        empty.frame = self.view.bounds;
    }
    return _emptyView;
}

// 点我找朋友 / 推荐
- (void)findFriendAction {
    DZHomeAttentionListRequest *request = [DZHomeAttentionListRequest dz_request];
    request.dz_url = kNHDiscoverRecommendUserListAPI;
    request.offset = 0;
    DZHomeAttentionListViewController *listController = [[DZHomeAttentionListViewController alloc] initWithRequest:request];
    [self pushVc:listController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
