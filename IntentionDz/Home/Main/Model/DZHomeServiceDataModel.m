//
//  DZHomeServiceDataModel.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/29.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZHomeServiceDataModel.h"
#import "MJExtension.h"

@implementation DZHomeServiceDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data":NSStringFromClass([NHHomeServiceDataElement class]),
             };
}
@end

@implementation NHHomeServiceDataElement
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"comments":NSStringFromClass([NHHomeServiceDataElementComment class]),
             };
}
@end

@implementation NHHomeServiceDataElementComment
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"reply_comments":NSStringFromClass([NHHomeServiceDataElementComment class]),
             };
}

@end

@implementation NHHomeServiceDataElementGroup
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"dislike_reason":NSStringFromClass([NHHomeServiceDataElementGroupDislike_reason class]),
             @"large_image_list":NSStringFromClass([NHHomeServiceDataElementGroupLargeImage class]),
             @"thumb_image_list":NSStringFromClass([NHHomeServiceDataElementGroupLargeImage class]),
             };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"video_360P": @"360p_video",
             @"video_720P": @"720p_video" ,
             @"video_480P":@"480p_video",
             };
}
@end

@implementation NHHomeServiceDataElementGroupLargeImage
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"url_list":NSStringFromClass([NHHomeServiceDataElementGroupLargeImageUrl class]),
             };
}
@end

@implementation NHHomeServiceDataElementGroupLargeImageUrl
@end

@implementation NHHomeServiceDataElementGroupDislike_reason
@end

@implementation NHHomeServiceDataElementGroupLarge_Image

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"url_list":NSStringFromClass([NHHomeServiceDataElementGroupLargeImageUrl class]),
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"video_360P": @"360p_video",
             @"video_720P": @"720p_video" ,
             @"video_480P":@"480p_video",
             };
}
@end

//
//@implementation NHHomeServiceDataElementGroupUser
//
//@end
@implementation NHHomeServiceDataElementGroupGifVideo

@end
