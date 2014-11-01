//
//  MWOriginalView.m
//  MAWeibo
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWStatusTopView.h"
#import "MWHomeCellFrame.h"
#import "MWStatuse.h"
#import "MWUser.h"
#import "UIImageView+WebCache.h"
#import "MWReweetView.h"
#import "MWPhoto.h"
#import "MWPhotosView.h"

@interface MWStatusTopView()
/** 头像 */
@property (weak,nonatomic) UIImageView *iconView;
/** 昵称 */
@property (weak,nonatomic) UILabel *nameLabel;
/** vip图像 */
@property (weak,nonatomic) UIImageView *vipView;
/** 来源 */
@property (weak,nonatomic) UILabel *sourceLabel;
/** 时间 */
@property (weak,nonatomic) UILabel *timeLabel;
/** 正文 */
@property (weak,nonatomic) UILabel *contentLabel;
/** 正文图片 */
@property (weak,nonatomic) MWPhotosView *photoView;

/** 转发微博的顶部View */
@property (weak,nonatomic) MWReweetView *retweetTopView;

@end

@implementation MWStatusTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizedImageWithName:@"common_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"common_card_top_background_highlighted"];
        
        /** 头像 */
        UIImageView *iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 昵称 */
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = MWHomeCellNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** vip图像 */
        UIImageView *vipView = [[UIImageView alloc]init];
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 来源 */
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = MWHomeCellSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 时间 */
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = MWHomeCellTimeFont;
        timeLabel.textColor = MWColor(244, 135, 0);
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 正文 */
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.font = MWHomeCellContentFont;
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        /** 正文图片 */
        MWPhotosView *photoView = [[MWPhotosView alloc]init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        /** 转发微博的顶部View */
        MWReweetView *retweetTopView = [[MWReweetView alloc]init];
        [self addSubview:retweetTopView];
        self.retweetTopView = retweetTopView;
    }
    return self;
}


- (void)setCellFrame:(MWHomeCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    MWStatuse *statuse = self.cellFrame.statuse;
    MWUser *user = statuse.user;
    
    /** 头像 */
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.cellFrame.iconViewF;
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.cellFrame.nameLabelF;
    /** vip图像 */
    if (user.mbtype) {
        self.vipView.hidden = NO;
        self.vipView.image =  [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];;
        self.vipView.frame = self.cellFrame.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 时间 */
    CGFloat timeLabelX = self.cellFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.cellFrame.nameLabelF) + MWStatusTableBorder;
    CGSize timeLabelWH = [statuse.created_at sizeWithFont:MWHomeCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelWH};
    self.timeLabel.text = statuse.created_at;
    
    /** 来源 */
    self.sourceLabel.textColor = [UIColor grayColor];
    self.sourceLabel.text = statuse.source;
    self.sourceLabel.frame = self.cellFrame.sourceLabelF;
    
    
    /** 正文 */
    self.contentLabel.text = statuse.text;
    self.contentLabel.frame = self.cellFrame.contentLabelF;
    /** 正文图片 */
    if (statuse.pic_urls.count) {
        self.photoView.hidden = NO;
        self.photoView.photos = statuse.pic_urls;
        self.photoView.frame = self.cellFrame.photoViewF;
    }else{
        self.photoView.hidden = YES;
    }
    
    
    // 转发微博数据
    MWStatuse *retweeted_status = self.cellFrame.statuse.retweeted_status;
    
    // 1. 父控件
    if (retweeted_status) {
        self.retweetTopView.hidden = NO;
        /** 转发微博的顶部View */
        self.retweetTopView.frame = self.cellFrame.retweetTopViewF;
        self.retweetTopView.cellFrame = self.cellFrame;
    }else{
        self.retweetTopView.hidden = YES;
    }
}



@end
