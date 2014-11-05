//
//  MWOAuthParam.m
//  MAWeibo
//
//  Created by admin on 14-11-5.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWOAuthParam.h"

@implementation MWOAuthParam
- (id)init
{
    self = [super init];
    if (self) {
        self.grant_type = @"authorization_code";
    }
    return self;
}

@end
