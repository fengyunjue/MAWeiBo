//
//  MWHomeStatueParam.h
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWBaseParam.h"

@interface MWHomeStatueParam : MWBaseParam
/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
 */
@property (nonatomic, strong) NSNumber *since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0
 */
@property (nonatomic, strong) NSNumber *max_id;
/**
 *  单页返回的记录条数，最大不超过100，默认为20
 */
@property (nonatomic, strong) NSNumber *count;
@end
