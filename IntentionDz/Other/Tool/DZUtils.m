//
//  DZUtils.m
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/29.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import "DZUtils.h"
#import "MJRefresh.h"
@implementation DZUtils
// 时间戳转时间
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format {
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

/** 开始下拉刷新 */
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;{
    [scrollView.mj_header beginRefreshing];
}
/**停止下拉刷新*/
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header endRefreshing];
}
/**
 *  公共富文本
 */
+ (NSAttributedString *)attStringWithString:(NSString *)string keyWord:(NSString *)keyWord;{
    return  [self attStringWithString:string keyWord:keyWord font:kFont(16) highlightedColor:kCommonHighLightRedColor textColor:kCommonBlackColor];
}

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor;{
    return [self attStringWithString:string keyWord:keyWord font:font highlightedColor:highlightedcolor textColor:textColor lineSpace:2.0];
}

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor
                                  lineSpace:(CGFloat)lineSpace;{
    if (string.length) {
        NSMutableAttributedString *attStr=[[NSMutableAttributedString alloc]initWithString:string];
        if (!keyWord||keyWord.length==0) {
            NSRange allRange=NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            //段落排版
            NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
            style.lineSpacing=lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        NSRange range=[string rangeOfString:keyWord options:NSCaseInsensitiveSearch];
        // 找到了关键字
        if (range.location != NSNotFound) {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:highlightedcolor range:range];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
        } else {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        return attStr.copy;
    }
    return [[NSAttributedString alloc] init];
}

+ (NSString *)validString:(NSString *)string {
    
    if ([self isBlankString:string]) {
        return  kEmptyStr;
    } else {
        return string;
    }
}
/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
