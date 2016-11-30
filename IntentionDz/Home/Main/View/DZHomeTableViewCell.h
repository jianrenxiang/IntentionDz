//
//  DZHomeTableViewCell.h
//  IntentionDz
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseTableViewCell.h"

@class DZBaseImageView;
typedef NS_ENUM(NSUInteger,DZHomeTableViewCellItemType){
    DZHomeTableViewCellItemTypeLike=1,
    DZHomeTableViewCellItemTypeDontLike,
    DZHomeTableViewCellItemTypeComment,
    DZHomeTableViewCellItemTypeShare,
};
@class DZHomeTableViewCellFrame,DZHomeTableViewCell,DZUserInfoModel;

@protocol DZHomeTableViewCellDelegate <NSObject>
//分类
-(void)homeTableViewCellDidClickCategory:(DZBaseTableViewCell*)cell;
//点击底部item
-(void)homeTableViewCell:(DZHomeTableViewCell*)cell didClickItemWithType:(DZHomeTableViewCellItemType)item;
//个人中心
-(void)homeTableViewCell:(DZHomeTableViewCell *)cell gotoPersonalCenterWithUserInfo:(DZUserInfoModel*)userInfo;
//点击浏览大图
-(void)homeTableViewCell:(DZHomeTableViewCell *)cell didClickImage:(UIImageView*)imageView currentIndex:(NSInteger)currentIndex urls:(NSArray <NSURL *> *)urls;
//播放视频过
-(void)homeTableViewCell:(DZHomeTableViewCell *)cell didClickImageVideoWithVideoUrl:(NSString*)videoUrl videoCover:(DZBaseImageView *)baseImageView;

@optional
/** 点击关注*/
- (void)homeTableViewCellDidClickAttention:(DZHomeTableViewCell *)cell;
/** 删除*/
- (void)homeTableViewCellDidClickClose:(DZHomeTableViewCell *)cell;
@end

@interface DZHomeTableViewCell : DZBaseTableViewCell
/** 首页cellFrame模型*/
@property (nonatomic, strong) DZHomeTableViewCellFrame *cellFrame;

@property(nonatomic,weak)id<DZHomeTableViewCellDelegate> delegate;

@property(nonatomic,assign)BOOL isFromHomeController;
-(void)setCellFrame:(DZHomeTableViewCellFrame*)cellFrame isDetail:(BOOL)isDetail;
//赞
-(void)didDing;
//踩
-(void)didBury;

@end
