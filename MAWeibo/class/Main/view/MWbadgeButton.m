//
//  MWbadgeButton.m
//  MAWeibo
//
//  Created by admin on 14-10-23.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWbadgeButton.h"

@implementation MWbadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.hidden = YES;
        self.userInteractionEnabled = NO;
            }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];

    if (_badgeValue) {
        // 设置提示数字
        [self setTitle:_badgeValue forState:UIControlStateNormal];
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
    

    
}


@end
