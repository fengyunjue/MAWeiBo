//
//  MWHomeCell.m
//  MAWeibo
//
//  Created by admin on 14-10-29.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWHomeCell.h"
#import "MWHomeCellFrame.h"
#import "MWstatuseToolBarView.h"
#import "MWStatusTopView.h"

@interface MWHomeCell()

/** 顶部View */
@property (weak,nonatomic) MWStatusTopView *topView;
/** 微博的工具条 */
@property (weak,nonatomic) MWstatuseToolBarView *statuseToolBar;

@end

@implementation MWHomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    MWHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MWHomeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectedBackgroundView = [[UIView alloc]init];
        /** 设置cell图片*/
        self.backgroundColor = MWColor(219, 219, 219);
        
        // 1. 设置顶部View
        MWStatusTopView *topView = [[MWStatusTopView alloc]init];
        [self addSubview:topView];
        self.topView = topView;
        
        // 2. 设置工具条
        MWstatuseToolBarView *statuseToolBar = [[MWstatuseToolBarView alloc]init];
        [self addSubview:statuseToolBar];
        self.statuseToolBar = statuseToolBar;
        
    }
    return self;
}

/**
 *  传递模型数据
 */
- (void)setCellFrame:(MWHomeCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    // 1.原创微博数据 顶部View
    self.topView.frame = self.cellFrame.topViewF;
    self.topView.cellFrame = self.cellFrame;
    
    // 2.微博工具条数据
    self.statuseToolBar.frame = self.cellFrame.statuseToolBarF;
    self.statuseToolBar.statuse = self.cellFrame.statuse;
}

/**
 *  重写setFrame方法
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = MWStatusTableBorder;
    frame.size.width -= MWStatusTableBorder * 2;
    frame.size.height -= MWStatusTableBorder;
    frame.origin.y += MWStatusTableBorder;
    [super setFrame:frame];
}
@end
