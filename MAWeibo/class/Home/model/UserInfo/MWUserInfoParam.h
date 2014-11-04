//
//  MWUserInfoParam.h
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWBaseParam.h"

@interface MWUserInfoParam : MWBaseParam
/**
 *  需要查询的用户ID。 (必填)
 */
@property (nonatomic, strong) NSNumber *uid;

@end
