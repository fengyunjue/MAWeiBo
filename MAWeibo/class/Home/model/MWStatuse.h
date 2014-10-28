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
/**
 *  微博内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  转发数
 */
@property (nonatomic, assign) long long reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) long long comments_count;

@property (strong, nonatomic) MWUser *user;

@end
/*
 {
 "statuses": [
 {
 "created_at": "Tue May 31 17:46:55 +0800 2011",
 "id": 11488058246,
 "text": "求关注。"
 "reposts_count": 8,
 "comments_count": 9,
 "user": {
 "id": 1404376560,
 "name": "zaku"
 "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
}
 }
 */