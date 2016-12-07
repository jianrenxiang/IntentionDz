//
//  DZHomeUserIconView.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/7.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZHomeUserIconView.h"
#import "UIView+Tap.h"
#import "UIView+Layer.h"


@interface DZHomeUserIconView ()
/** 头像*/
@property (nonatomic, weak) DZBaseImageView *iconImg;
@end

@implementation DZHomeUserIconView


+ (instancetype)iconView {
    return [[self alloc] init];
}

- (void)setIconUrl:(NSString *)iconUrl {
    _iconUrl = iconUrl;
    if (iconUrl.length) {
        [self.iconImg setImageWithUrl:iconUrl];
    }
}

- (void)setImage:(UIImage *)image {
    _image = image;
    if (image) {
        self.iconImg.image = image;
    }
}

- (DZBaseImageView *)iconImg {
    if (!_iconImg) {
        DZBaseImageView *icon = [[DZBaseImageView alloc] init];
        [self addSubview:icon];
        _iconImg = icon;
        icon.userInteractionEnabled = YES;
        WeakSelf(weakSelf);
        [icon setTapActionWithBlock:^{
            if (weakSelf.homeUserIconViewDidClickHandle) {
                weakSelf.homeUserIconViewDidClickHandle(weakSelf);
            }
        }];
        icon.contentMode = UIViewContentModeScaleAspectFill;
        icon.clipsToBounds = YES;
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        icon.layerCornerRadius = 17.5;
    }
    return _iconImg;
}


@end
