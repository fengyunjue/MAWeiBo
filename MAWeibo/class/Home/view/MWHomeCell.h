//
//  MWHomeCell.h
//  MAWeibo
//
//  Created by admin on 14-10-29.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MWHomeCellFrame;
@interface MWHomeCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) MWHomeCellFrame *cellFrame;

@end
