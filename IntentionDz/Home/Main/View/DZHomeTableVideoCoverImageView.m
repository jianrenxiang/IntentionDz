//
//  DZHomeTableVideoCoverImageView.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/30.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZHomeTableVideoCoverImageView.h"

@interface DZHomeTableVideoCoverImageView ()
@property (nonatomic, weak) UIButton *playBtn;
@end

@implementation DZHomeTableVideoCoverImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    return self;
}

-(UIButton*)playBtn{
    if (!_playBtn) {
        UIButton *play=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:play];
        _playBtn=play;
        WeakSelf(weakSelf);
        [play mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.center.equalTo(weakSelf);
        }];
        [play addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(void)playBtnClick:(UIButton*)btn{
    if (self.homeTableCellVideoDidBeginPlayeHandle) {
        self.homeTableCellVideoDidBeginPlayeHandle(btn);
    }
}

@end
