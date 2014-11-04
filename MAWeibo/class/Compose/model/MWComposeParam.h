//
//  MWComposeParam.h
//  MAWeibo
//
//  Created by admin on 14-11-4.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWBaseParam.h"

@interface MWComposeParam : MWBaseParam
/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字
 */
@property (nonatomic, copy) NSString *status;
/**
 *  微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0
 */
@property (nonatomic, strong) NSNumber *visible;
/**
 *  微博的保护投递指定分组ID，只有当visible参数为3时生效且必选
 */
@property (nonatomic, copy) NSString *list_id;
///**
// *  要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M
// */
//@property (nonatomic, strong) NSData *pic;

@end
