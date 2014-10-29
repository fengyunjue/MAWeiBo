//
//  MWAccount.m
//  MAWeibo
//
//  Created by admin on 14-10-27.
//  Copyright (c) 2014年 mage. All rights reserved.
// 账号模型
//

#import "MWAccount.h"

#define MWAccountToolFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation MWAccount 

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[MWAccount alloc]initWithDict:dict];
}
/**
 *  编译
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
}

/**
 *  反编译
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
    }
    return self;
}
/**
 *  存储用户账号信息
 */
+ (void)saveAccount:(MWAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:MWAccountToolFile];
}
/**
 *  获取用户账号信息
 */
+(MWAccount *)account
{
    NSLog(@"%@",MWAccountToolFile);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:MWAccountToolFile];
}


@end
