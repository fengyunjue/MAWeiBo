//
//  MWOAuthViewController.m
//  MAWeibo
//
//  Created by admin on 14-10-27.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWOAuthViewController.h"
#import "AFNetworking.h"
#import "MWAccount.h"
#import "MBProgressHUD+MW.h"
#import "MWWeiboTool.h"


@interface MWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation MWOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 添加webView
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    // 2. 加载授权页面(新浪提供的登录页面)MWAuthorize
    NSURL *url = [NSURL URLWithString:MWAuthorize];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
    
}
/**
 *  webView请求开始
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"哥正在努力加载中"];
}
/**
 *  webView请求结束
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

/**
 *  当webView发送一个请求之前都会调用此方法,询问代理可不可以加载这个页面(请求)
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1. 请求的URL路径
    NSString *urlStr = request.URL.absoluteString;
    // 2. 查找code=在URL中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length != 0) {
        int loc = range.length + range.location;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 3. 发送POST
        [self accessTokenWithCode:code];
        return NO;
    }
    
    return YES;
}
/**
 *  向新浪服务器发送请求
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1. 创建请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 2. 封装请求参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"client_id"] = MWAppKey;
    dict[@"client_secret"] = MWAppSecret;
    dict[@"grant_type"] = @"authorization_code";
    dict[@"code"] = code;
    dict[@"redirect_uri"] = MWRedirectURL;
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 将用户登录信息保存到文件中去
        MWAccount *account = [MWAccount accountWithDict:responseObject];
        [MWAccount saveAccount:account];
        
        // 隐藏提示窗口
        [MBProgressHUD hideHUD];
        
        // 跳转到下一个页面
        [UIApplication sharedApplication].keyWindow.rootViewController = [MWWeiboTool MWWeiboToolDecideNewVersions];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MALog(@"%@",error);
    }];
}


@end
