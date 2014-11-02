//
//  MWCompuseViewController.m
//  MAWeibo
//
//  Created by admin on 14-11-2.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWCompuseViewController.h"
#import "MWTextView.h"

@interface MWCompuseViewController ()
@property (nonatomic ,weak) MWTextView *textView;
@end

@implementation MWCompuseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.title = @"发微博";
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    MWTextView *textView = [[MWTextView alloc]initWithFrame:self.view.frame];
    textView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textView];
    self.textView = textView;
    [MWNotificationCenter addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:textView];
}
/**
 *  textView的文字变化
 */
- (void)textChanged
{
    // 有内容,发送键可以点击
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
    
}
/**
 *  发送
 */
- (void)send
{
    
}
/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [MWNotificationCenter removeObserver:self];
}
/**
 *  在DidAppear中显示键盘
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.textView becomeFirstResponder];
}

@end
