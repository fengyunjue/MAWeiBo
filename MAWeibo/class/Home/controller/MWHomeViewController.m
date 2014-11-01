//
//  MWHemoViewController.m
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWHomeViewController.h"
#import "UIBarButtonItem+MA.h"
#import "MWTitleButton.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MWAccount.h"
#import "MWStatuse.h"
#import "MWUser.h"
#import "MJExtension.h"
#import "MWHomeCellFrame.h"
#import "MWHomeCell.h"

@interface MWHomeViewController ()
// 微博数据数组
@property (strong, nonatomic) NSArray *statusesFrame;
// 用户名按钮
@property (nonatomic ,weak) MWTitleButton *titleButton;

@end

@implementation MWHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1. 集成刷新控件
    [self setupRefreshView];
   
    // 2. 初始化界面
    [self setupView];
    
    // 3. 获取用户信息
    [self setupUserData];

}
/**
 *  获取用户信息
 */
-(void)setupUserData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2. 封装请求参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    MWAccount *account = [MWAccount account];
    dict[@"access_token"] = account.access_token;
    dict[@"uid"] = @(account.uid);
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MWUser *user = [MWUser objectWithKeyValues:responseObject];
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        MWAccount *account = [MWAccount account];
        account.name = user.name;
        [MWAccount saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        MALog(@"%@",error);
    }];
}

/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:refreshControl];
    
    // 第一次进入刷新数据
    [refreshControl beginRefreshing];
    [self refreshView:refreshControl];
}

- (void)refreshView:(UIRefreshControl *)refreshControl
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2. 封装请求参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    MWAccount *account = [MWAccount account];
    dict[@"access_token"] = account.access_token;
    if (self.statusesFrame.count) {
        MWHomeCellFrame *cellFrame = self.statusesFrame[0];
        dict[@"since_id"] = cellFrame.statuse.idstr;
    }
    
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 从数组字典中获取数据模型
        NSArray *array = [MWStatuse objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 创建Frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (MWStatuse *stause in array) {
            MWHomeCellFrame *cellFrame = [[MWHomeCellFrame alloc]init];
            // 传递微博模型数据
            cellFrame.statuse = stause;
            [statusFrameArray addObject:cellFrame];
        }
        // 新建一个数组
        NSMutableArray *list = [NSMutableArray array];
        // 将刷新的元素加入数组
        [list addObjectsFromArray:statusFrameArray];
        // 将旧元素加入数组
        [list addObjectsFromArray:self.statusesFrame];
        
        self.statusesFrame = list;
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
        
        // 提示用户更新了多少新微博
        [self showStatueCount:statusFrameArray.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 让刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
        MALog(@"%@",error);
    }];
}
/**
 *  显示用户更新了多少新微博
 *
 *  @param count 新微博的数量
 */
- (void)showStatueCount:(NSInteger)count
{
    UIButton *btn = [[UIButton alloc]init];
    btn.userInteractionEnabled = NO;
    // below : 下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"%d条新微博",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有新微博" forState:UIControlStateNormal];
    }
    
    // 这是按钮位置
    CGFloat btnX = 3;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [UIView animateWithDuration:0.7f animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7f delay:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
            // 清除形变
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}


/**
 *  数据源方法
 */
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusesFrame.count;
}
/**
 *  代理方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 创建cell
    MWHomeCell *cell = [MWHomeCell cellWithTableView:tableView];

    
    // 2. 传递frame模型
    cell.cellFrame = self.statusesFrame[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MWHomeCellFrame *cellFrame = self.statusesFrame[indexPath.row];
    return cellFrame.cellHeight;
}

/**
 *  初始化界面
 */
- (void)setupView
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:nil action:nil];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:nil action:nil];
    
    // 中间按钮
    MWTitleButton *titleButton = [[MWTitleButton alloc]init];
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    titleButton.frame = CGRectMake(0, 0, 0, 40);
    if ([MWAccount account].name) {
        NSString *name = [MWAccount account].name;
        [titleButton setTitle:name forState:UIControlStateNormal];
    
    }else{
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }

    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleButton = titleButton;
    self.navigationItem.titleView = titleButton;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    // cell周围的颜色
    self.tableView.backgroundColor = MWColor(226, 226, 226);
}

- (void)titleClick:(MWTitleButton *)titlebutton
{
    if (titlebutton.currentImage == [UIImage imageWithName:@"navigationbar_arrow_up"]) {
        [titlebutton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }else{
        [titlebutton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }
}

@end
