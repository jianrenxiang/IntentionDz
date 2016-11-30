//
//  DZHomeTableVideoCoverImageView.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/30.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseImageView.h"

@interface DZHomeTableVideoCoverImageView : DZBaseImageView

@property(nonatomic,copy)void(^homeTableCellVideoDidBeginPlayeHandle)(UIButton *player);

@end
