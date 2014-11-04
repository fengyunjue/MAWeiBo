//
//  MWHomeStatueResult.m
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWHomeStatueResult.h"
#import "MJExtension.h"
#import "MWStatuse.h"

@implementation MWHomeStatueResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [MWStatuse class]};
}

@end
