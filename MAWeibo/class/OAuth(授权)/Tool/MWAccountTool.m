//
//  MWAccountTool.m
//  MAWeibo
//
//  Created by admin on 14-10-27.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWAccountTool.h"

#define MWAccountToolFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation MWAccountTool

+ (void)saveAccount:(MWAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:MWAccountToolFile];
}

+(MWAccount *)account
{
    MALog(@"%@",MWAccountToolFile);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:MWAccountToolFile];
}

@end
