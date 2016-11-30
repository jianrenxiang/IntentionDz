//
//  DZDownLoadImageManger.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/30.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZDownLoadImageManger : NSObject

+ (void)downLoadImageWithURL:(NSURL *)URL finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle;
+ (void)downLoadImageWithURL:(NSURL *)URL finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle
              progressHandle:(void(^)(CGFloat progres))progressHandle;

+ (void)downLoadImageWithUrl:(NSString *)url finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle;
+ (void)downLoadImageWithUrl:(NSString *)url finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle
              progressHandle:(void(^)(CGFloat progres))progressHandle;

+ (UIImage *)cacheImageWithUrl:(NSString *)url;
+ (UIImage *)cacheImageWithURL:(NSURL *)URL;
@end
