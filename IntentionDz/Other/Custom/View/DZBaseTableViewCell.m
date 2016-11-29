//
//  DZBaseTableViewCell.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/28.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZBaseTableViewCell.h"

@implementation DZBaseTableViewCell

-(UITableView*)tableView{
    float version=[[UIDevice currentDevice].systemVersion floatValue];
    if (version>=7.0) {
        return (UITableView*)self.superview.superview;
    }else{
       return (UITableView*)self.superview;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellAccessoryNone;
        self.contentView.backgroundColor=[UIColor clearColor];
    }
    return self;
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    if (tableView==nil) {
        return [[self alloc]init];
    }
    NSString *classname=NSStringFromClass([self class]);
    NSString *identifier=[classname stringByAppendingString:@"CellID"];
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

+ (instancetype)nibCellWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifier = [classname stringByAppendingString:@"nibCellID"];
    UINib *nib = [UINib nibWithNibName:classname bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}
- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
