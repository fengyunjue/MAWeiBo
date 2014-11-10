//
//  MWUserUnreadCountResult.m
//  MAWeibo
//
//  Created by admin on 14-11-5.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWUserUnreadCountResult.h"

@implementation MWUserUnreadCountResult

- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt +self.mention_status;
}

- (int)count
{
    return self.messageCount + self.status + self.follower;
}

@end
