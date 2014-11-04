//
//  MWFormData.h
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWFormData : NSObject
/**
 *  需要发送的数据文件
 */
@property (nonatomic, strong) NSData *data;
/**
 *  新浪接收参数
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件位置
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
