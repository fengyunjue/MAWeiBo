//
//  MWToolBar.h
//  MAWeibo
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    MWComposeToolBarButtonTypeCamera,
    MWComposeToolBarButtonTypePicture,
    MWComposeToolBarButtonTypeMention,
    MWComposeToolBarButtonTypeTrend,
    MWComposeToolBarButtonTypeEmotion
}MWComposeToolBarButtonType;

@class MWComposeToolBar;
@protocol MWComposeToolBarDelegate <NSObject>
@optional
- (void)composeToolBar:(MWComposeToolBar *)toolBar ButtonType:(MWComposeToolBarButtonType)type;

@end
@interface MWComposeToolBar : UIView

@property (nonatomic ,weak) id<MWComposeToolBarDelegate> delegate;

@end
