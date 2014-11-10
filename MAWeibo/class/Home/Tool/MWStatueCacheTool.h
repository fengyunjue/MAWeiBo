//
//  MWStatueCacheTool.h
//  MAWeibo
//
//  Created by admin on 14-11-6.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MWHomeStatueParam;

@interface MWStatueCacheTool : NSObject
/**
 *  保存微博数组
 *
 *  @param array 微博数组字典
 */
+ (void)saveStatueWithArray:(NSArray *)array;
/**
 *  保存一条微博数据
 *
 *  @param dict 一条微博字典
 */
+ (void)saveStatueWithDict:(NSDictionary *)dict;
/**
 *  获取数据数组
 *
 *  @param param 参数
 *
 *  @return 数据数组
 */
+ (NSArray *)getStatuesWithParam:(MWHomeStatueParam *)param;
@end
