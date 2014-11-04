//
//  MWHomeStatueResult.h
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MWHomeStatueResult : NSObject
/**
 *  存放MWStatuse的数据模型
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  微博总数
 */
@property (nonatomic, assign) long long total_number;

@property (nonatomic, assign) long long previous_cursor;
@property (nonatomic, assign) long long next_cursor;

@end
