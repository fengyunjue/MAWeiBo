//
//  MWAccountTool.h
//  MAWeibo
//
//  Created by admin on 14-10-27.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWAccount.h"

@interface MWAccountTool : NSObject

+ (void)saveAccount:(MWAccount *)account;

+ (MWAccount *)account;

@end
