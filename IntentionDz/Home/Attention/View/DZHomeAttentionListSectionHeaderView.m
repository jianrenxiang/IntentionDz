//
//  DZHomeAttentionListSectionHeaderView.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/12/6.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZHomeAttentionListSectionHeaderView.h"

@implementation DZHomeAttentionListSectionHeaderView

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    if (textColor) {
        self.tipL.textColor = textColor;
    }
}

- (void)setTipText:(NSString *)tipText {
    if (tipText == nil) {
        return ;
    }
    _tipText = tipText;
    self.tipL.text = [NSString stringWithFormat:@"  %@", tipText];
}

- (UILabel *)tipL {
    if (!_tipL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _tipL = label;
        label.font = kFont(15);
        label.textColor = kTextColor;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tipL;
}

@end
