//
//  MWHomeCell.m
//  MAWeibo
//
//  Created by admin on 14-10-29.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWHomeCell.h"
#import "MWHomeCellFrame.h"
#import "MWStatuse.h"
#import "MWUser.h"
#import "UIImageView+WebCache.h"

@interface MWHomeCell()
/** 顶部View */
@property (weak,nonatomic) UIImageView *topView;
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
@property (weak,nonatomic) UIImageView *photoView;


/** 转发微博的顶部View */
@property (weak,nonatomic) UIImageView *retweetTopView;
/** 转发微博的作者 */
@property (weak,nonatomic) UILabel *retweetNameLabel;
/** 转发微博的正文 */
@property (weak,nonatomic) UILabel *retweetContentLabel;
/** 转发微博的正文图片 */
@property (weak,nonatomic) UIImageView *retweetphotoView;


/** 微博的工具条 */
@property (weak,nonatomic) UIImageView *statuseToolBar;

@end

@implementation MWHomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    MWHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MWHomeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1. 设置原创View
        [self setupOriginalSubViews];
        
        // 2. 设置转发微博View
        [self setupRetweetSubViews];
        
        // 3. 设置工具条
        [self setupWeiboSubViews];
        
    }
    return self;
}
/**
 *  设置原创View
 */
-(void)setupOriginalSubViews
{
    
    /** 顶部View */
    UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage resizedImageWithName:@"timeline_card_top_background"]];
    [self addSubview:topView];
    self.topView = topView;
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc]init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = MWHomeCellNameFont;
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** vip图像 */
    UIImageView *vipView = [[UIImageView alloc]init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = MWHomeCellSourceFont;
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = MWHomeCellTimeFont;
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = MWHomeCellContentFont;
    contentLabel.numberOfLines = 0;
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    /** 正文图片 */
    UIImageView *photoView = [[UIImageView alloc]init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
}
/**
 *  设置转发微博View
 */
- (void)setupRetweetSubViews
{
    /** 转发微博的顶部View */
    UIImageView *retweetTopView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"timeline_card_top_background"]];
    [self addSubview:retweetTopView];
    self.retweetTopView = retweetTopView;
    /** 转发微博的作者 */
    UILabel *retweetNameLabel = [[UILabel alloc]init];
    retweetNameLabel.font = MWHomeReweetStatuseNameFont;
    [self.retweetTopView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    /** 转发微博的正文 */
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.font = MWHomeReweetStatuseContentFont;
    retweetContentLabel.numberOfLines = 0;
    [self.retweetTopView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    /** 转发微博的正文图片 */
    UIImageView *retweetphotoView = [[UIImageView alloc]init];
    [self.retweetTopView addSubview:retweetphotoView];
    self.retweetphotoView = retweetphotoView;
}
/**
 *  设置工具条
 */
- (void)setupWeiboSubViews
{
    /** 微博的工具条 */
    UIImageView *statuseToolBar = [[UIImageView alloc]init];
    [self addSubview:statuseToolBar];
    self.statuseToolBar = statuseToolBar;
}
/**
 *  传递模型数据
 */
- (void)setCellFrame:(MWHomeCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    // 1.原创微博
    [self setupOriginalData];
    
    // 2.被转发微博
    [self setupRetweetData];
    
    // 3.微博工具条
    [self setupStatusToolbar];
}

/**
 *  原创微博
 */
- (void)setupOriginalData
{
    MWStatuse *statuse = self.cellFrame.statuse;
    MWUser *user = statuse.user;
    
    
    /** 顶部View */
    self.topView.frame = self.cellFrame.topViewF;
    /** 头像 */
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.cellFrame.iconViewF;
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.cellFrame.nameLabelF;
    /** vip图像 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:@"common_icon_membership"];
        self.vipView.frame = self.cellFrame.vipViewF;
    }else{
        self.vipView.hidden = YES;
    }
    /** 来源 */
    self.sourceLabel.text = statuse.source;
    self.sourceLabel.frame = self.cellFrame.sourceLabelF;
    /** 时间 */
    self.timeLabel.text = statuse.created_at;
    self.timeLabel.frame = self.cellFrame.timeLabelF;
    /** 正文 */
    self.contentLabel.text = statuse.text;
    self.contentLabel.frame = self.cellFrame.contentLabelF;
    /** 正文图片 */
    if (statuse.thumbnail_pic) {
        self.photoView.hidden = NO;
        [self.photoView setImageWithURL:[NSURL URLWithString:statuse.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        self.photoView.frame = self.cellFrame.photoViewF;
    }else{
        self.photoView.hidden = YES;
    }
}

/**
 *  被转发微博
 */
- (void)setupRetweetData
{
    MWStatuse *reweetStatuse = self.cellFrame.statuse.reweetStatuse;
    MWUser *user = reweetStatuse.user;
    
    // 1. 父控件
    if (reweetStatuse) {
        self.retweetTopView.hidden = NO;
        /** 转发微博的顶部View */
        self.retweetTopView.frame = self.cellFrame.retweetTopViewF;
        
        /** 转发微博的作者 */
        self.retweetNameLabel.text = user.name;
        self.retweetNameLabel.frame = self.cellFrame.retweetNameLabelF;
        
        /** 转发微博的正文 */
        self.retweetContentLabel.text = reweetStatuse.text;
        self.retweetContentLabel.frame = self.cellFrame.retweetContentLabelF;
        
        /** 转发微博的正文图片 */
        if (reweetStatuse.thumbnail_pic) {
            self.retweetphotoView.hidden = NO;
            [self.retweetphotoView setImageWithURL:[NSURL URLWithString:reweetStatuse.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
            self.retweetphotoView.frame = self.cellFrame.retweetphotoViewF;
        }else{
            self.retweetphotoView.hidden = YES;
        }
    }else{
        self.retweetTopView.hidden = YES;
    }
}

/**
 *  微博工具条
 */
- (void)setupStatusToolbar
{
    self.statuseToolBar.frame = self.cellFrame.statuseToolBarF;
}


@end
