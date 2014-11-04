//
//  MWHttpTool.h
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWHttpTool : NSObject
/**
 *  get请求
 *
 *  @param url     请求路径
 *  @param param   请求参数
 *  @param success 请求成功地回调结果
 *  @param failure 请求成功地回调结果
 */
+ (void)getWithUrl:(NSString *)url param:(id)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  post请求
 *
 *  @param url     请求路径
 *  @param param   请求参数
 *  @param success 请求成功地回调结果
 *  @param failure 请求成功地回调结果
 */
+ (void)postWithUrl:(NSString *)url param:(id)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  带文件的post请求
 *
 *  @param url     请求路径
 *  @param param   请求参数
 *  @param dataArray 需要上传的数据
 *  @param success 请求成功地回调结果
 *  @param failure 请求成功地回调结果
 */
+ (void)postWithUrl:(NSString *)url param:(id)param dataArray:(NSArray *)dataArray success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


@end
