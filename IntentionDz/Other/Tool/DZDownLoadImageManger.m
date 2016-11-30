//
//  DZDownLoadImageManger.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/30.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZDownLoadImageManger.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "YYWebImage.h"
#import "UIImage+Addition.h"
@implementation DZDownLoadImageManger
+ (void)downLoadImageWithURL:(NSURL *)URL finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle {
    [self downLoadImageWithURL:URL finishHandle:finishHandle progressHandle:nil];
}
@end
