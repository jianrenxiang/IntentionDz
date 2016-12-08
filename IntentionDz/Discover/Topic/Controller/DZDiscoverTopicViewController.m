//
//  DZDiscoverTopicViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/8.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZDiscoverTopicViewController.h"
#import "DZHomeBaseViewController.h"
#import "DZDiscoverModel.h"
#import "DZDiscoverTopicRequest.h"
@interface DZDiscoverTopicViewController ()
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NHDiscoverCategoryElement *element;
@property (nonatomic, strong) DZHomeBaseViewController *controller;
@end

@implementation DZDiscoverTopicViewController
- (instancetype)initWithCatogoryId:(NSInteger)categoryId {
    if (self = [super init]) {
        self.categoryId = categoryId;
    }
    return self;
}

- (instancetype)initWithCategoryElement:(NHDiscoverCategoryElement *)element {
    if (self = [super init]) {
        self.element = element;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpItems];
    
    [self loadData];
}
- (void)setUpItems {
    if (self.element.name) {
        self.navigationItem.title = self.element.name;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"submission"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

- (void)rightItemClick {
//    NHPublishDraftViewController *publishController = [[NHPublishDraftViewController alloc] init];
//    [self pushVc:publishController];
}
// 请求数据
- (void)loadData  {

    DZDiscoverTopicRequest *request = [DZDiscoverTopicRequest dz_request];
    request.dz_url = kNHHomeCategoryDynamicListAPI;
    request.count = 30;
    request.level = 6;
    request.category_id = self.element ? self.element.ID : self.categoryId;
    request.message_cursor = 0;
    request.mpic = 1;
    DZHomeBaseViewController *controller = [[DZHomeBaseViewController alloc] initWitnRequest:request];
    [self addChildVc:controller];
    _controller = controller;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
