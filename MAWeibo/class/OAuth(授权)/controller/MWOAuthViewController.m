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
#import "MWOAuthTool.h"


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

- (void)accessTokenWithCode:(NSString *)code
{
    // 1. 封装请求参数
    MWOAuthParam *param = [[MWOAuthParam alloc]init];
    param.client_id = MWAppKey;
    param.client_secret = MWAppSecret;
    param.code = code;
    param.redirect_uri = MWRedirectURL;
    [MWOAuthTool OAuthWithParam:param success:^(MWOAuthResult *result) {
        // 将用户登录信息保存到文件中去
        [MWAccount saveAccount:result];
        // 隐藏提示窗口
        [MBProgressHUD hideHUD];
        // 跳转到下一个页面
        [UIApplication sharedApplication].keyWindow.rootViewController = [MWWeiboTool MWWeiboToolDecideNewVersions];
        
    } failure:^(NSError *error) {
        
    }];
}


@end
