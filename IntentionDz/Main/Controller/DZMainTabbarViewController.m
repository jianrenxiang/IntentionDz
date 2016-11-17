//
//  DZMainTabbarViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZMainTabbarViewController.h"
#import "DZBaseNavigationViewController.h"
#import "DZHomeViewController.h"
#import "DZCheckViewController.h"
#import "DZMessageViewController.h"
#import "DZDiscoverViewController.h"
#import "DZServiceListRequest.h"
#import "NHServiceListModel.h"
@interface DZMainTabbarViewController ()

@end

@implementation DZMainTabbarViewController
//该方法和init不同，如果初始化三次，但该方法直走一次
+(void)initialize{
    //设置不透明
    [[UITabBar appearance]setTranslucent:NO];
    //设置tabbar栏颜色
    [UITabBar appearance].barTintColor=tabbarBottonColor;
    //控制导航栏的外观
    UITabBarItem *item=[UITabBarItem appearance];
    item.titlePositionAdjustment=UIOffsetMake(0, 1.5);
    //    普通状态
    NSMutableDictionary *normalAttrs=[[NSMutableDictionary alloc]init];
    normalAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    normalAttrs[NSForegroundColorAttributeName]=tabbarBottonNormalTextColor;
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    //    按下去状态
    NSMutableDictionary *selectAttr=[[NSMutableDictionary alloc]init];
    selectAttr[NSForegroundColorAttributeName]=tabbarBottonSelectTextColor;
    selectAttr[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:selectAttr forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllerWithClassname:[DZHomeViewController description] imagename:@"home" title:@"首页"];
    [self addChildViewControllerWithClassname:[DZDiscoverViewController description] imagename:@"Found" title:@"发现"];
    [self addChildViewControllerWithClassname:[DZCheckViewController description] imagename:@"audit" title:@"审核"];
    [self addChildViewControllerWithClassname:[DZMessageViewController description] imagename:@"newstab" title:@"消息"];
    DZServiceListRequest *request=[DZServiceListRequest dz_request];
    request.dz_url=kNHHomeServiceListAPI;
    [request dz_sendRequestWithCompletion:^(id reponse, BOOL success, NSString *message) {
        if (success) {
            DZBaseNavigationViewController *homeNav=(DZBaseNavigationViewController*)self.viewControllers.firstObject;
            DZHomeViewController *home=(DZHomeViewController*)homeNav.viewControllers.firstObject;
            home.models=[NHServiceListModel modelArrayWithDictArray:reponse];
        }
    }];
}

-(void)addChildViewControllerWithClassname:(NSString *)classname imagename:(NSString*)imagename title:(NSString*)title{
    UIViewController *vc=[[NSClassFromString(classname) alloc]init];
    DZBaseNavigationViewController *navi=[[DZBaseNavigationViewController alloc]initWithRootViewController:vc];
    navi.tabBarItem.title=title;
    navi.tabBarItem.image=[UIImage imageNamed:imagename];
    navi.tabBarItem.selectedImage=[[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:navi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
