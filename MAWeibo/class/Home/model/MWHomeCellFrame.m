//
//  MWHomeCellFrame.m
//  MAWeibo
//
//  Created by admin on 14-10-29.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWHomeCellFrame.h"
#import "MWStatuse.h"
#import "MWUser.h"


@implementation MWHomeCellFrame

- (void)setStatuse:(MWStatuse *)statuse
{
    _statuse = statuse;
    
    // 1. 设置SubView的Frame
    [self setupOriginalSubViewsF];
}
/**
 *  设置原创View的Frame
 */
- (void)setupOriginalSubViewsF
{
    /** 顶部View */
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewW = [UIScreen mainScreen].applicationFrame.size.width - 2 * MWStatusTableBorder;
    CGFloat topViewH = 0;
    
    /** 头像 */
    CGFloat iconViewX = MWStatusTableBorder;
    CGFloat iconViewY = MWStatusTableBorder;
    CGFloat iconViewWH = 35;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    /** 昵称 */
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + MWStatusTableBorder;
    CGFloat nameLabelY = MWStatusTableBorder;
    CGSize nameLabelSize = [self.statuse.user.name sizeWithFont:MWHomeCellNameFont];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    /** vip图像 */
    if (self.statuse.user.mbtype) {
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + MWStatusTableBorder;
        CGFloat vipViewY = nameLabelY;
        CGFloat vipViewWH = 14;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewWH, vipViewWH);
    }
    
    /** 时间 */
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + MWStatusTableBorder;
    CGSize timeLabelWH = [self.statuse.created_at sizeWithFont:MWHomeCellTimeFont];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelWH};
    
    /** 来源 */
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + MWStatusTableBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelWH = [self.statuse.source sizeWithFont:MWHomeCellSourceFont];
    
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelWH};
    
    /** 正文 */
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_sourceLabelF)) + MWStatusTableBorder;
    CGFloat contentLabelMaxW = topViewW - 2 * MWStatusTableBorder;
    CGSize contentLabelWH = [self.statuse.text sizeWithFont:MWHomeCellSourceFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelWH};
    
    /** 正文图片 */
    if (self.statuse.pic_urls.count) {
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + MWStatusTableBorder;
        CGFloat photoViewWH = 60;
        _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
    }
    
    
    
    /** 转发的微博 */
    if (self.statuse.retweeted_status) {
//        MALog(@"转发了微博");
        /** 转发微博的顶部View */
        CGFloat retweetTopViewX = contentLabelX;
        CGFloat retweetTopViewY = CGRectGetMaxY(_contentLabelF) + MWStatusTableBorder;
        CGFloat retweetTopViewW = topViewW - MWStatusTableBorder * 2;
        CGFloat retweetTopViewH = 0;
        
        /** 转发微博的作者 */
        CGFloat retweetNameLabelX = retweetTopViewX;
        CGFloat retweetNameLabelY = CGRectGetMaxY(_retweetTopViewF) + 2 * MWStatusTableBorder;
        CGSize retweetNameLabelWH = [[NSString stringWithFormat:@"@%@",self.statuse.retweeted_status.user.name] sizeWithFont:MWHomeReweetStatuseNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY},retweetNameLabelWH};
        /** 转发微博的正文 */
        CGFloat retweetContentLabelX = contentLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + MWStatusTableBorder;
        CGFloat retweetContentLabelMaxW = retweetTopViewW - 2 * MWStatusTableBorder;
        CGSize retweetContentLabelWH = [self.statuse.retweeted_status.text sizeWithFont:MWHomeReweetStatuseContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelWH};
        
        /** 转发微博的正文图片 */
        if (self.statuse.retweeted_status.pic_urls.count) {
            CGFloat retweetphotoViewX = retweetContentLabelX;
            CGFloat retweetphotoViewY = CGRectGetMaxY(_retweetContentLabelF) + MWStatusTableBorder;
            CGFloat retweetphotoViewWH = 60;
            _retweetphotoViewF = CGRectMake(retweetphotoViewX, retweetphotoViewY, retweetphotoViewWH, retweetphotoViewWH);
            
            // 如果有图片
            retweetTopViewH = CGRectGetMaxY(_retweetphotoViewF) + MWStatusTableBorder;
        }else{
            // 如果没有图片
            retweetTopViewH = CGRectGetMaxY(_retweetContentLabelF) + MWStatusTableBorder;
        }
        // 转发微博的视图设置
        _retweetTopViewF = CGRectMake(retweetTopViewX, retweetTopViewY, retweetTopViewW, retweetTopViewH);
        
        // 如果有转发微博,topView的高度
        topViewH = CGRectGetMaxY(_retweetTopViewF);
    }else{
        // 如果没有转发微博,topView的高度
        if (self.statuse.pic_urls.count) {
            topViewH = CGRectGetMaxY(_photoViewF) ;
        }else{
            topViewH = CGRectGetMaxY(_contentLabelF)  ;
        }
    }
    
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH + MWStatusTableBorder);
    
     /** 微博工具条 */
    CGFloat statuseToolBarX = topViewX;
    CGFloat statuseToolBarY = CGRectGetMaxY(_topViewF);
    CGFloat statuseToolBarW = topViewW;
    CGFloat statuseToolBarH = 40;
    _statuseToolBarF = CGRectMake(statuseToolBarX, statuseToolBarY, statuseToolBarW, statuseToolBarH);
    
    /** Cell的高度 */
    _cellHeight = CGRectGetMaxY(_statuseToolBarF) + MWStatusTableBorder;
}

@end
