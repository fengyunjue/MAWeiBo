//
//  MWStatueCacheTool.m
//  MAWeibo
//
//  Created by admin on 14-11-6.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWStatueCacheTool.h"
#import "FMDB.h"
#import "MWAccount.h"
#import "MWHomeStatueParam.h"

@implementation MWStatueCacheTool
static FMDatabaseQueue *_queue;
+ (void)initialize
{

    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    // 创表
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_statuse (id integer primary key autoincrement, idstr text, dict blob, access_token text);"];
        if (!result) {
            MALog(@"创表失败");
        }
    }];
}


+ (void)saveStatueWithArray:(NSArray *)array
{
    for (NSDictionary *dict in array) {
        [self saveStatueWithDict:dict];
    }
}

+ (void)saveStatueWithDict:(NSDictionary *)dict
{
    [_queue inDatabase:^(FMDatabase *db) {
        MWAccount *account = [MWAccount account];
        NSString *access_token = account.access_token;
        NSString *idstr = dict[@"idstr"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        // 2. 存储数据
        [db executeUpdate:@"insert into t_statuse (idstr, dict, access_token) values ( ?, ?, ?) ;", idstr, data, access_token];
    }];
}

+ (NSArray *)getStatuesWithParam:(MWHomeStatueParam *)param
{
    // 定义数组
    __block NSMutableArray *dictArray = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        dictArray = [NSMutableArray array];
        FMResultSet *result = nil;
        if (param.max_id) {
           result = [db executeQuery:@"select * from t_statuse where access_token = ? and idstr <= ? order by idstr desc limit 0, ? ; ", param.access_token, param.max_id, param.count];
        }else if (param.since_id){
            result = [db executeQuery:@"select * from t_statuse where access_token = ? and idstr > ? order by idstr desc limit 0, ? ; ", param.access_token, param.since_id, param.count];
        }else{
            result = [db executeQuery:@"select * from t_statuse where access_token = ?  order by idstr desc limit 0, ? ; ", param.access_token, param.count];
        }
        while (result.next) {
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[result dataForColumn:@"dict"]];
            [dictArray addObject:dict];
        }
    }];
    // 返回数据
    return dictArray;
}
@end
