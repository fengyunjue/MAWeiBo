//
//  MWUserUnreadCountResult.h
//  MAWeibo
//
//  Created by admin on 14-11-5.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWUserUnreadCountResult : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;
/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;
/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;
/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;
/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;
/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  消息的总数
 */
- (int)messageCount;
@end
