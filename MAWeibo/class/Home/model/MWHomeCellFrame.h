//
//  MWHomeCellFrame.h
//  MAWeibo
//
//  Created by admin on 14-10-29.
//  assignright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 视图间的间距 */
#define MWStatusTableBorder 5

/** Cell间的间距 */
#define MWStatusCellBorder 5

/**昵称字体*/
#define MWHomeCellNameFont [UIFont systemFontOfSize:12]


/**时间字体*/
#define MWHomeCellTimeFont MWHomeCellNameFont
/**来源字体*/
#define MWHomeCellSourceFont MWHomeCellNameFont

/**正文字体*/
#define MWHomeCellContentFont MWHomeCellNameFont

/**转发微博的昵称字体*/
#define MWHomeReweetStatuseNameFont [UIFont systemFontOfSize:12]
/**转发微博的正文字体*/
#define MWHomeReweetStatuseContentFont [UIFont systemFontOfSize:12]


@class MWStatuse;
@interface MWHomeCellFrame : NSObject

@property (nonatomic, strong) MWStatuse *statuse;

/** 顶部View */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** vip图像 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 正文 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
/** 正文图片 */
@property (nonatomic, assign, readonly) CGRect photoViewF;


/** 转发微博的顶部View */
@property (nonatomic, assign, readonly) CGRect retweetTopViewF;
/** 转发微博的作者 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 转发微博的正文 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 转发微博的正文图片 */
@property (nonatomic, assign, readonly) CGRect retweetphotoViewF;


/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statuseToolBarF;

/** Cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;


@end
