//
//  MWUser.h
//  MAWeibo
//
//  Created by admin on 14-10-28.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWUser : NSObject
/**用户ID*/
@property (nonatomic, copy) NSString *idstr;
/**用户昵称*/
@property (nonatomic, copy) NSString *name;
/**用户头像*/
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  是否为vip
 */
//@property (nonatomic, assign, getter = isVip) BOOL vip;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;

@end