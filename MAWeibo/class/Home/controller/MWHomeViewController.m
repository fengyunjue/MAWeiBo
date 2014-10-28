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
#import "MWAccountTool.h"
#import "UIImageView+WebCache.h"

@interface MWHomeViewController ()
// 微博数据数组
@property (strong, nonatomic)NSArray *statuses;

@end

@implementation MWHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化界面
    [self setupView];
    
    [self getDataSourse];
    

}
/**
 *  发送网络请求接受网络数据
 */
- (void)getDataSourse
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2. 封装请求参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    MWAccount *account = [MWAccountTool account];
    dict[@"access_token"] = account.access_token;
//    dict[@"count"] = @1;
    
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.statuses = responseObject[@"statuses"];
        MALog(@"%@",self.statuses);
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MALog(@"%@",error);
    }];
}

/**
 *  数据源方法
 */
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}
/**
 *  代理方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // 取出一条数据
    NSDictionary *dict = self.statuses[indexPath.row];
    cell.textLabel.text = dict[@"text"];
    cell.detailTextLabel.text = dict[@"user"][@"name"];
    NSString *urlstr = dict[@"user"][@"profile_image_url"];
    [cell.imageView setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"]];
    return cell;
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
