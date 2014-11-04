//
//  MWCompuseTool.h
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//  发送微博工具类

#import <Foundation/Foundation.h>
#import "MWComposeParam.h"
#import "MWComposeResult.h"
@interface MWComposeTool : NSObject
/**
 *  发送一条没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调结果
 *  @param failure 请求失败后的回调结果
 */
+ (void)composeWithoutImageWithParam:(MWComposeParam *)param success:(void (^)(MWComposeResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一条有图片的微博
 *
 *  @param param     请求参数
 *  @param dataArray 数据数组
 *  @param success   请求成功后的回调结果
 *  @param failure   请求失败后的回调结果
 */
+ (void)composeWithImageWithParam:(MWComposeParam *)param dataArray:(NSArray *)dataArray success:(void (^)(MWComposeResult *result))success failure:(void (^)(NSError *error))failure;
@end
