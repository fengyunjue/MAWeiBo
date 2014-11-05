//
//  MWUserUnreadCountParam.h
//  MAWeibo
//
//  Created by admin on 14-11-5.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWBaseParam.h"

@interface MWUserUnreadCountParam : MWBaseParam

/**
 *  需要获取消息未读数的用户UID，必须是当前登录用户
 */
@property (nonatomic, strong) NSNumber *uid;
/**
 *  JSONP回调函数，用于前端调用返回JS格式的信息
 */
@property (nonatomic, copy) NSString *callback;
/**
 *  未读数版本。0：原版未读数，1：新版未读数。默认为0
 */
@property (nonatomic, assign) BOOL unread_message;

@end
