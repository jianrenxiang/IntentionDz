//
//  DZHomeTopTipView.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/29.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZHomeTopTipView.h"

@interface DZHomeTopTipView ()
@property (nonatomic, weak) UILabel *tipL;
@end

@implementation DZHomeTopTipView

-(void)setTipText:(NSString *)tipText{
    _tipText=tipText;
    if (_tipText) {
        self.tipL.text=tipText;
    }
}

-(UILabel*)tipL{
    if (!_tipL) {
        UILabel *tip=[[UILabel alloc]init];
        [self addSubview:tip];
        _tipL=tip;
        tip.textColor=kWhiteColor;
        tip.backgroundColor=kCommonHighLightRedColor;
        tip.textAlignment=NSTextAlignmentCenter;
        tip.font=kFont(12);
        WeakSelf(weakSelf);
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
    }
    return _tipL;
}

@end
