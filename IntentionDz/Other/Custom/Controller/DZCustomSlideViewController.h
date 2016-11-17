//
//  DZCustomSlideViewController.h
//  IntentionDz
//
//  Created by EWSAPPLE on 16/11/17.
//  Copyright © 2016年 com.ews. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZCustomSlideViewController;
@protocol DZCustomSlideControllerDelegate <NSObject>
@required
//滑动偏移量
-(void)customSlideViewController:(DZCustomSlideViewController*)slideViewController slideOffset:(CGPoint)slideOffset;
-(void)customSlideViewController:(DZCustomSlideViewController*)slideViewController slideOffIndex:(NSInteger)slideOffIndex;
@end
@protocol DZCustomSlideControllerDataSoure <NSObject>

-(UIViewController*)slideViewController:(DZCustomSlideViewController*)slideViewController viewControllerAtIndex:(NSInteger)index;
-(NSInteger)numberofChildViewControllerInSlideViewController:(DZCustomSlideViewController*)slideViewController;

@end
@interface DZCustomSlideViewController : UIViewController
@property(nonatomic,weak)id<DZCustomSlideControllerDelegate> delegate;
@property(nonatomic,weak)id<DZCustomSlideControllerDataSoure> datasoure;
@property(nonatomic,assign)NSInteger selectIndex;
-(void)reloadDate;
@end
