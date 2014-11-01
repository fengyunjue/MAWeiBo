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

@end

@implementation MWHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1. 集成刷新控件
    [self setupRefreshView];
   
    // 初始化界面
    [self setupView];
    
//    [self getDataSourse];

}

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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 让刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
        MALog(@"%@",error);
    }];
}
///**
// *  发送网络请求接受网络数据
// */
//- (void)getDataSourse
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    // 2. 封装请求参数
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    
//    MWAccount *account = [MWAccount account];
//    dict[@"access_token"] = account.access_token;
////    dict[@"count"] = @2;
//    
//    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        // 从数组字典中获取数据模型
//        NSArray *array = [MWStatuse objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
//        // 创建Frame模型对象
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        for (MWStatuse *stause in array) {
//            MWHomeCellFrame *cellFrame = [[MWHomeCellFrame alloc]init];
//            // 传递微博模型数据
//            cellFrame.statuse = stause;
//            [statusFrameArray addObject:cellFrame];
//        }
//        self.statusesFrame = statusFrameArray;
//        // 刷新表格
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        MALog(@"%@",error);
//    }];
//}

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
    [titleButton setTitle:@"哈哈哈" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton setFrame:CGRectMake(0, 0, 80, 40)];
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
