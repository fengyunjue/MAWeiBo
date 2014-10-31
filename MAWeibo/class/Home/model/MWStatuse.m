//
//  MWStatuse.m
//  MAWeibo
//
//  Created by admin on 14-10-28.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWStatuse.h"
#import "NSDate+MJ.h"
#import "MJExtension.h"
#import "MWPhoto.h"

@implementation MWStatuse

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [MWPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *inputFormatter  =[[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"EEE MMM d HH:mm:ss Z yyyy"];
    NSDate *createdTime = [inputFormatter dateFromString:_created_at];
    
    // 获取当前时间
    NSDate *new = [NSDate date];
    NSTimeInterval timeInterval =  [new timeIntervalSinceDate:createdTime];
    int time = (int)timeInterval;
    NSString *timeStr = nil;
    
    //    MALog(@"%d---%@",time, createdTime);
    
    // 判断时间格式
    if (time >= 1 && time < 60) {// 1分钟内
        timeStr = @"刚刚";
        
    }else if(time >= 60 && time < 3600){// 1小时内
        timeStr = [NSString stringWithFormat:@"%d分钟前",time / 60];
        
    }else if(time >= 360 && time < 8640){// 今天以内
        [inputFormatter setDateFormat:@"今天 HH:mm"];
        timeStr  = [inputFormatter stringFromDate:createdTime];
    }else{
        // 一天以前
        [inputFormatter setDateFormat:@"mm月d日 HH:mm"];
        timeStr = [inputFormatter stringFromDate:createdTime];
        
    }
    return timeStr;
}


- (void)setSource:(NSString *)source
{
    NSRange range = [source rangeOfString:@">"];
    NSString *sourceS = [source substringFromIndex:range.length + range.location];
    NSRange range1 = [sourceS rangeOfString:@"<"];
    NSString *sourceStr = [sourceS substringToIndex:range1.location];
//    MALog(@"%@--%@--%@",source,NSStringFromRange(range),sourceStr);
    
//        int loc = [source rangeOfString:@">"].location + 1;
//    int length = [source rangeOfString:@"</"].location - loc;
//    source = [source substringWithRange:NSMakeRange(loc, length)];
//
//    _source = [NSString stringWithFormat:@"来自%@", source];
    
    _source = [NSString stringWithFormat:@"来自%@",sourceStr];
   
}

@end
