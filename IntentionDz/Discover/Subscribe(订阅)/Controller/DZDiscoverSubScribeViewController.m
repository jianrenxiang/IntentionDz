//
//  DZDiscoverSubScribeViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/8.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZDiscoverSubScribeViewController.h"
#import "DZDiscoverSubscribeListRequest.h"
#import "DZCustomCommonEmptyView.h"
#import "DZDiscoverModel.h"
@interface DZDiscoverSubScribeViewController ()
@property (nonatomic, weak) DZCustomCommonEmptyView *emptyView;
@end

@implementation DZDiscoverSubScribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DZDiscoverSubscribeListRequest *request = [DZDiscoverSubscribeListRequest dz_request];
    request.dz_url = kNHDiscoverSubscribeListAPI;
    [request dz_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            self.dataArray = [NHDiscoverCategoryElement modelArrayWithDictArray:response];
            [self nh_reloadData];
            self.emptyView.hidden = self.dataArray.count > 0;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
