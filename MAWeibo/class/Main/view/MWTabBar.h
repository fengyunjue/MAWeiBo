//
//  MWTabBar.h
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MWTabBar;
@protocol MWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MWTabBar *)tabBar didselectButtonFrom:(NSInteger)from to:(NSInteger)to;

- (void)tabBarDidClickPlusButton:(MWTabBar *)tabBar;

@end

@interface MWTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (weak,nonatomic) id<MWTabBarDelegate> delegate;

@end
