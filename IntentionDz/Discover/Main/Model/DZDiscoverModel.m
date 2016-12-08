//
//  DZDiscoverModel.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/8.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZDiscoverModel.h"

@implementation DZDiscoverModel

@end


@implementation NHDiscoverGodComment

@end

@implementation NHDiscoverCategories
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"category_list":NSStringFromClass([NHDiscoverCategoryElement class]),
             };
}

@end

@implementation NHDiscoverCategoryElement



@end

@implementation NHDiscoverRotate_banner

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"banners":NSStringFromClass([NHDiscoverRotate_bannerElement class]),
             };
}
@end

@implementation NHDiscoverRotate_bannerElement


@end

@implementation NHDiscoverRotate_bannerElementBanner_url
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"url_list":NSStringFromClass([NHDiscoverRotate_bannerElementBanner_url_URL class]),
             };
}


@end

@implementation NHDiscoverRotate_bannerElementBanner_url_URL

@end
