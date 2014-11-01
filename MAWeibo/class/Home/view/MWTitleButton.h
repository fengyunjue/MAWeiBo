//
//  MWTitleButton.h
//  MAWeibo
//
//  Created by admin on 14-10-26.
//  Copyright (c) 2014年 mage. All rights reserved.
//  
//

#import <UIKit/UIKit.h>

@interface MWTitleButton : UIButton

+ (instancetype)titleButton;

/**
 *  根据按钮的标题计算宽度
 */
- (CGSize)getSizeWithTitle:(NSString *)title;

@end
