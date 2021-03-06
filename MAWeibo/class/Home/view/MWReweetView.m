//
//  MWReweetView.m
//  MAWeibo
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWReweetView.h"
#import "MWHomeCellFrame.h"
#import "MWStatuse.h"
#import "MWUser.h"
#import "UIImageView+WebCache.h"
#import "MWPhotosView.h"

@interface MWReweetView()
/** 转发微博的作者 */
@property (weak,nonatomic) UILabel *retweetNameLabel;
/** 转发微博的正文 */
@property (weak,nonatomic) UILabel *retweetContentLabel;
/** 转发微博的正文图片 */
@property (weak,nonatomic) MWPhotosView *retweetphotoView;

@end

@implementation MWReweetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" withleft:0.9 top:0.5];
        /** 转发微博的作者 */
        UILabel *retweetNameLabel = [[UILabel alloc]init];
        retweetNameLabel.font = MWHomeReweetStatuseNameFont;
        retweetNameLabel.textColor = [UIColor orangeColor];
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        /** 转发微博的正文 */
        UILabel *retweetContentLabel = [[UILabel alloc]init];
        retweetContentLabel.font = MWHomeReweetStatuseContentFont;
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        /** 转发微博的正文图片 */
        MWPhotosView *retweetphotoView = [[MWPhotosView alloc]init];
        [self addSubview:retweetphotoView];
        self.retweetphotoView = retweetphotoView;
    }
    return self;
}

- (void)setCellFrame:(MWHomeCellFrame *)cellFrame
{
    _cellFrame = cellFrame;

    MWStatuse *retweeted_status = cellFrame.statuse.retweeted_status;
    MWUser *user = retweeted_status.user;
    /** 转发微博的作者 */
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
   
    self.retweetNameLabel.frame = self.cellFrame.retweetNameLabelF;
    /** 转发微博的正文 */
    self.retweetContentLabel.text = retweeted_status.text;
    self.retweetContentLabel.frame = self.cellFrame.retweetContentLabelF;
    
    /** 转发微博的正文图片 */
    if (retweeted_status.pic_urls.count) {
        self.retweetphotoView.hidden = NO;
        self.retweetphotoView.photos = retweeted_status.pic_urls;
        self.retweetphotoView.frame = self.cellFrame.retweetphotoViewF;
    }else{
        self.retweetphotoView.hidden = YES;
    }
}

@end
