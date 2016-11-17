//
//  DZBaseNavigationViewController.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/15.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseNavigationViewController.h"

@interface DZBaseNavigationViewController ()

@end

@implementation DZBaseNavigationViewController

+(void)initialize{
//    该方法让所有布局从navi下面开始
    [[UINavigationBar appearance]setTranslucent:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
