//
//  MWUser.h
//  MAWeibo
//
//  Created by admin on 14-10-28.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWUser : NSObject
/**
 *  用户ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *profile_image_url;


@end
/*
 "user": {
 "id": 1404376560,
 "name": "zaku"
 "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
 }
 */