//
//  MWTextView.m
//  MAWeibo
//
//  Created by admin on 14-11-2.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWComposeTextView.h"
@interface MWComposeTextView()

@property (nonatomic ,weak) UILabel *placeholderLabel;
@end

@implementation MWComposeTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UILabel *placeholderLabel = [[UILabel alloc]init];
        [placeholderLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:placeholderLabel];
        placeholderLabel.numberOfLines = 0;
        self.placeholderLabel = placeholderLabel;
        [MWNotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textChange
{
    self.placeholderLabel.hidden = (self.text.length != 0);
}

/**
 *  设置提示文字
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = self.font;
}
/**
 *  设置提示文字颜色
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat labelX = 5;
    CGFloat labelY = 9;
    CGSize size = [self.placeholderLabel.text sizeWithFont:self.placeholderLabel.font constrainedToSize:self.frame.size];
    self.placeholderLabel.frame = CGRectMake(labelX, labelY, size.width, size.height);
}

- (void)dealloc
{
    [MWNotificationCenter removeObserver:self];
}

@end
