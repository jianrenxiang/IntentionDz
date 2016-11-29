//
//  DZBaseTableViewCell.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/28.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZBaseTableViewCell : UITableViewCell

@property(nonatomic,weak)UITableView *tableView;

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(instancetype)nibWithTableView:(UITableView *)tableView;

@end
