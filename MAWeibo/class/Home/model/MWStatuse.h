//
//  MWStatuse.h
//  MAWeibo
//
//  Created by admin on 14-10-28.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MWUser;

@interface MWStatuse : NSObject
/**
 *  微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**微博内容*/
@property (nonatomic, copy) NSString *text;
/**转发数*/
@property (nonatomic, assign) int reposts_count;
/**评论数*/
@property (nonatomic, assign) int comments_count;
/**表态数*/
@property (nonatomic, assign) int attitudes_count;
/**来源*/
@property (nonatomic, copy) NSString *source;
/**微博时间*/
@property (nonatomic, copy) NSString *created_at;
/**微博配图*/
//@property (nonatomic, copy) NSString *thumbnail_pic ;
/**微博图片组 (数组中装模型:IWPhoto)*/
@property (nonatomic, strong) NSArray *pic_urls;
/**作者*/
@property (strong, nonatomic) MWUser *user;

/**转发的微博*/
@property (nonatomic, strong) MWStatuse *retweeted_status;
@end
