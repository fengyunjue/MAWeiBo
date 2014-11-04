//
//  MWBaseParam.m
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWBaseParam.h"
#import "MWAccount.h"

@implementation MWBaseParam

- (id)init
{
    self = [super init];
    if (self) {
        MWAccount *account = [MWAccount account];
        self.access_token = account.access_token;
    }
    return self;
}
@end
