//
//  MWstatuseToolBarView.m
//  MAWeibo
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWstatuseToolBarView.h"
#import "MWStatuse.h"

@interface MWstatuseToolBarView()
@property (nonatomic ,weak) UIButton *reweetButton;
@property (nonatomic ,weak) UIButton *commentButton;
@property (nonatomic ,weak) UIButton *likeButton;
// 按钮中间的分割线
@property (nonatomic ,weak) UIImageView *lineImageView;

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *lines;

@end

@implementation MWstatuseToolBarView

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (NSMutableArray *)lines
{
    if (_lines == nil) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizedImageWithName:@"common_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"common_card_bottom_background_highlighted"];
        // 初始化subView
        [self setupSubViews];
    }
    return self;
}
/**
 *  初始化subView
 */
- (void)setupSubViews
{
    self.reweetButton = [self createButtonWithTitle:@"转发" ImageName:@"timeline_icon_retweet" bgImageName:@"timeline_card_leftbottom_highlighted"];
    self.commentButton = [self createButtonWithTitle:@"评论" ImageName:@"timeline_icon_comment" bgImageName:@"timeline_card_middlebottom_highlighted"];
    self.likeButton = [self createButtonWithTitle:@"赞" ImageName:@"timeline_icon_unlike" bgImageName:@"timeline_card_leftbottom_highlighted"];
    
    [self createLineImageView];
    [self createLineImageView];
}
- (void)createLineImageView
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"timeline_card_bottom_line"]];
    [self addSubview:imageView];
    [self.lines addObject:imageView];
}

- (UIButton *)createButtonWithTitle:(NSString *)title ImageName:(NSString *)imageName bgImageName:(NSString *)bgImageName
{
    UIButton *btn = [[UIButton alloc]init];
    // 设置高亮禁止渲染
    btn.adjustsImageWhenHighlighted = NO;
    // 设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    // 设置文字字体
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设置文字颜色
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    // 设置按钮图片
    [btn setImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    // 设置图片与按钮之间的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    // 设置背景图片
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImageName] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    
    [self.buttons addObject:btn];
    return btn;
}

- (void)layoutSubviews
{

    CGFloat lineY = 0;
    CGFloat lineW = 2;
    CGFloat lineH = self.frame.size.height;
    
    CGFloat btnY = 0;
    CGFloat btnW = (self.frame.size.width - self.lines.count * lineW) / self.buttons.count;
    CGFloat btnH = self.frame.size.height;
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        UIButton *btn = self.buttons[i];
       CGFloat btnX = btnW * i + 2;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
 
    for (NSInteger i = 0; i < self.lines.count; i++) {
        UIImageView *imageView = self.lines[i];
        // 设置frame
        UIButton *button = self.buttons[i];
        CGFloat lineX = CGRectGetMaxX(button.frame);
        imageView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    }
    
}

- (void)setStatuse:(MWStatuse *)statuse
{
    _statuse = statuse;
    [self setupBtn:self.reweetButton originalTitle:@"转发" count:statuse.reposts_count];
    [self setupBtn:self.commentButton originalTitle:@"评论" count:statuse.comments_count];
    [self setupBtn:self.likeButton originalTitle:@"赞" count:statuse.attitudes_count];
}
/**
 *  计算count的数值
    1000  显示 1000
    10424 显示 1万
    12343 显示 1.2万
    12845 显示 1.3万
 */
- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count
{
    NSString *countStr = nil;
    if (count) {
        if (count < 10000) {
            countStr = [NSString stringWithFormat:@"%d",count];
        }else{
            double c = count / 10000.0;
            NSString *countS = [NSString stringWithFormat:@"%.1f万",c];
            countStr = [countS stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }else{
        countStr = originalTitle;
    }
    [btn setTitle:countStr forState:UIControlStateNormal];
}

@end
